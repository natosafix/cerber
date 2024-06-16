export class DraftTicketDto {
    public id: number;
    public name: string;
    public price?: number;
    public cover?: File;
    public coverImageId?: string;

    constructor(name: string, price: number, cover?: File, coverImageId?: string) {
        this.name = name;
        this.price = price;
        this.cover = cover;
        this.coverImageId = coverImageId;
    }
}