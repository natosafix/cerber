import { TicketDto } from '../../../../Api/Models/TicketDto';
import { DraftTicketDto } from '../../../../Api/Models/DraftTicketDto';

export class Ticket {
    public static fromDto(viewId: number, ticketDto: DraftTicketDto): Ticket {
        let ticket = new Ticket(viewId);
        // TODO вместе с cover нужен CoverId
        return ticket;
    }
    
    public ViewId: number;
    public Name: string;
    public Price?: number;
    public Cover: File;

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

    public withCover(cover: File): Ticket {
        this.Cover = cover;
        return this;
    }
}