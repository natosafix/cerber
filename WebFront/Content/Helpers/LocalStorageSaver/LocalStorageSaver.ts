export class LocalStorageSaver implements ILocalStorageSaver {
    formsKeys = 'forms';
    formName: string;

    constructor(formName: string) {
        this.formName = formName;
        // localStorage.clear();

        let savedForms = JSON.parse(localStorage.getItem(this.formsKeys) || 'false');
        if (!savedForms) {
            savedForms = {};
        }

        if (!(this.formName in savedForms)) {
            savedForms[this.formName] = {};
            localStorage.setItem(this.formsKeys, JSON.stringify(savedForms));
        }
    }

    load(key: string): string | null {
        let savedForms = JSON.parse(localStorage.getItem(this.formsKeys) || 'false');
        if (!savedForms) {
            return null;
        }
        return savedForms[this.formName][key];
    }

    save(key: string, value: string) {
        let savedForms = JSON.parse(localStorage.getItem(this.formsKeys)!);
        savedForms[this.formName][key] = value;
        localStorage.setItem(this.formsKeys, JSON.stringify(savedForms));
    }

}