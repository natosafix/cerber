using System.Security.Cryptography;
using System.Text;

namespace Web.Services.Implementations;

public class EncryptionService : IEncryptionService
{
    private const string EncryptedValuePrefix = "EncryptedValue:";
    
    public string DecryptString(string text, byte[] key)
    {
        if (string.IsNullOrWhiteSpace(text) || !IsEncrypted(text))
            return text;
 
        var vector = Convert.FromBase64String(text.Split(';')[0].Split(':')[1]);
        return Decrypt(Convert.FromBase64String(text.Split(';')[1]), key, vector);
    }
    
    public string EncryptString(string text, byte[] key)
    {
        if (string.IsNullOrWhiteSpace(text) || IsEncrypted(text))
            return text;
        
        var vector = GenerateInitializationVector();
        var encryptedText = Convert.ToBase64String(Encrypt(text, key, vector));
        return EncryptedValuePrefix + Convert.ToBase64String(vector) + ";" + encryptedText;
    }
 
    public bool IsEncrypted(string text) => 
        text.StartsWith(EncryptedValuePrefix, StringComparison.OrdinalIgnoreCase);
    
    private string Decrypt(byte[] encryptedBytes, byte[] key, byte[] vector)
    {
        using (var aesAlgorithm = Aes.Create())
        using (var decryptor    = aesAlgorithm.CreateDecryptor(key, vector))
        using (var memoryStream = new MemoryStream(encryptedBytes))
        using (var cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
        using (var streamReader = new StreamReader(cryptoStream, Encoding.UTF8))
        {
            return streamReader.ReadToEnd();
        }
    }
    
    private byte[] Encrypt(string plainText, byte[] key, byte[] vector)
    {
        using (var aesAlgorithm = Aes.Create())
        using (var encryptor    = aesAlgorithm.CreateEncryptor(key, vector))
        using (var memoryStream = new MemoryStream())
        using (var cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write))
        {
            using (var streamWriter = new StreamWriter(cryptoStream, Encoding.UTF8))
            {
                streamWriter.Write(plainText);
            }
 
            return memoryStream.ToArray();
        }
    }
 
    private byte[] GenerateInitializationVector()
    {
        var aesAlgorithm = Aes.Create();
        aesAlgorithm.GenerateIV();
        
        return aesAlgorithm.IV;
    }
}