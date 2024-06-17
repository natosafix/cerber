export interface IEventStats {
    soldTicketsCount: Number;
    ticketsStats: TicketStats[];
}

interface TicketStats {
    name: string
    quantity: number;
    price: number;
}