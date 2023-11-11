interface ILocalStorageSaver {
    save(key: string, value: string);
    load(key: string): string | null;
}