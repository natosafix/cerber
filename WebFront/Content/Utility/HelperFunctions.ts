export const isNullOrWhiteSpace = (v?: string | null) => {
    return v === null || !v || v.trim() === '';
};
