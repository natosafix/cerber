﻿using Domain.Entities;
using Web.Persistence.Repositories;

namespace Web.Services.Implementations;

public class UserFilesService : IUserFilesService
{
    private const string DefaultPath = "Files";

    private readonly IUserFilesRepository userFilesRepository;
    private readonly IStorageManager storageManager;
    private readonly IUserHelper userHelper;

    public UserFilesService(
        IUserFilesRepository userFilesRepository,
        IStorageManager storageManager,
        IUserHelper userHelper)
    {
        this.userFilesRepository = userFilesRepository;
        this.storageManager = storageManager;
        this.userHelper = userHelper;
    }

    public async Task<UserFile> Get(int id)
    {
        return await userFilesRepository.Get(id) ?? throw new BadHttpRequestException($"Not found file with id {id}");
    }

    public async Task<UserFile?> TryGet(int id)
    {
        return await userFilesRepository.Get(id);
    }

    public async Task<byte[]> GetContent(UserFile userFile)
    {
        return await storageManager.Get(userFile.Path);
    }

    public Stream GetContentStream(UserFile userFile)
    {
        return storageManager.GetFileStream(userFile.Path);
    }

    public async Task<UserFile> Save(IFormFile formFile, bool generateName = false)
    {
        var username = userHelper.Username;
        var userFile = new UserFile
        {
            Name = generateName ? Guid.NewGuid().ToString() : formFile.FileName,
            Path = Path.Combine(DefaultPath, username, formFile.FileName)
        };
        await storageManager.Save(formFile, userFile.Path);
        return await userFilesRepository.Save(userFile);
    }

    public async Task<IReadOnlyCollection<UserFile>> Save(
        IReadOnlyCollection<IFormFile> formFile,
        bool generateName = false)
    {
        var result = new List<UserFile>(formFile.Count);

        foreach (var file in formFile)
        {
            var userFile = await Save(file, generateName);
            result.Add(userFile);
        }

        return result;
    }

    public async Task Remove(UserFile userFile)
    {
        await userFilesRepository.Remove(userFile);
        storageManager.Remove(userFile.Path);
    }

    public async Task Remove(int userFileId)
    {
        var userFile = await Get(userFileId);
        await userFilesRepository.Remove(userFileId);
        storageManager.Remove(userFile.Path);
    }
}