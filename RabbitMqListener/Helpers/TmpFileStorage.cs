using System;
using System.IO;

namespace RabbitMQListener.Helpers;

public class TmpFileStorage : IDisposable
{
    public static TmpFileStorage FromBytes(string fileName, byte[] bytes)
    {
        fileName = Path.Combine(TmpFileDir, fileName);
        var fileInfo = new FileInfo(fileName);
        fileInfo.Directory!.Create();
        File.WriteAllBytes(fileInfo.FullName, bytes);
        return new TmpFileStorage(fileInfo);
    }

    private const string TmpFileDir = "Tmp";

    public TmpFileStorage(FileInfo fileInfo)
    {
        FileInfo = fileInfo;
    }

    public FileInfo FileInfo { get; }

    public void Dispose()
    {
        FileInfo.Delete();
    }
}