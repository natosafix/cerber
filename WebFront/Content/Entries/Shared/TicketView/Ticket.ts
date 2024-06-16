import { DraftTicketDto } from '../../../../Api/Models/DraftTicketDto';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';

export class Ticket {
    public static async fromDto(viewId: number, ticketDto: DraftTicketDto): Promise<Ticket> {
        const file = await EventAdminClient.getTicketImage(ticketDto.id);
        let ticket = new Ticket(viewId).withPrice(ticketDto.price).withName(ticketDto.name).withCover(file);
        console.log(ticket);
        return ticket;
    }

    public ViewId: number;
    public Name: string;
    public Price?: number;
    public Cover: Blob;

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

    public withCover(cover: Blob): Ticket {
        this.Cover = cover;
        return this;
    }
}
