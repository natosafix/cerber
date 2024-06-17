import { DraftTicketDto } from '../../../../Api/Models/DraftTicketDto';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';

export class Ticket {
    public static async fromDto(viewId: number, ticketDto: DraftTicketDto): Promise<Ticket> {
        const file = await EventAdminClient.getTicketImage(ticketDto.id);
        return new Ticket(viewId)
            .withPrice(ticketDto.price)
            .withName(ticketDto.name)
            .withCover(file)
            .withQr(ticketDto.qrCodeX, ticketDto.qrCodeY, ticketDto.qrCodeSize);
    }

    public ViewId: number;
    public Name: string;
    public Price?: number;
    public Cover?: Blob;
    public QrCodeX?: number;
    public QrCodeY?: number;
    public QrCodeSize?: number;

    constructor(viewId: number) {
        this.ViewId = viewId;
    }

    public withName(name: string): Ticket {
        this.Name = name;
        return this;
    }

    public withPrice(price?: number): Ticket {
        this.Price = price;
        return this;
    }

    public withCover(cover?: Blob): Ticket {
        this.Cover = cover;
        return this;
    }

    public withQr(qrCodeX?: number, qrCodeY?: number, qrCodeSize?: number): Ticket {
        this.QrCodeX = qrCodeX;
        this.QrCodeY = qrCodeY;
        this.QrCodeSize = qrCodeSize;
        return this;
    }
}
