namespace Web.Services;

public interface IEncryptionService
{
    string DecryptString(string text, byte[] key);

    string EncryptString(string text, byte[] key);

    byte[] GenerateInitializationVector();
}