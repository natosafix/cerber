export interface IEventStats {
    soldTicketsCount: Number;
    ticketsStats: TicketStats[];
    ticketsByInspector: Map<string, TicketStats[]>;
    inspectors: string[];
}

export interface TicketStats {
    name: string
    quantity: number;
    price: number;
}