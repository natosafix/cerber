export const isNullOrWhiteSpace = (v?: string) => {
    return !v || v.trim() === '';
};
