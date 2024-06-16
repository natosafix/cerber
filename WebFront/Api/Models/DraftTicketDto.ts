export class DraftTicketDto {
    public id: number;
    public name: string;
    public price?: number;
    public cover?: Blob;
    public coverImageId?: string;

    constructor(name: string, price: number, cover?: Blob, coverImageId?: string) {
        this.name = name;
        this.price = price;
        this.cover = cover;
        this.coverImageId = coverImageId;
    }
}
