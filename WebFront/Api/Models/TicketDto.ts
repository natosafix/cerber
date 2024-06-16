export class TicketDto {
    public id: number;
    public name: string;
    public price?: number;
    public cover?: File;

    constructor(name: string, price: number, cover?: File) {
        this.name = name;
        this.price = price;
        this.cover = cover;
    }
}