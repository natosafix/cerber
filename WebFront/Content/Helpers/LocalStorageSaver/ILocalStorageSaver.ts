interface ILocalStorageSaver {
    save(key: string, value: string);
    load(key: string): string | null;
    delete(key: string): boolean;
}