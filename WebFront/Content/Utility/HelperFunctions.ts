export const isNullOrWhiteSpace = (v: string | undefined) => {
    return !v || v.trim() === '';
};
