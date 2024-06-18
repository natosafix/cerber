export class DraftTicketDto {
    public id: number;
    public name: string;
    public price?: number;
    public cover?: Blob;
    public coverImageId?: string;
    public qrCodeX?: number;
    public qrCodeY?: number;
    public qrCodeSize?: number;

    constructor(
        name: string,
        price: number,
        cover?: Blob,
        qrCodeX?: number,
        qrCodeY?: number,
        qrCodeSize?: number,
        coverImageId?: string,
    ) {
        this.name = name;
        this.price = price;
        this.cover = cover;
        this.coverImageId = coverImageId;
        this.qrCodeY = qrCodeY;
        this.qrCodeX = qrCodeX;
        this.qrCodeSize = qrCodeSize;
    }
}
