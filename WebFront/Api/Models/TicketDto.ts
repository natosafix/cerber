﻿export class TicketDto {
    public Name: string;
    public Price?: number;

    constructor(name: string, price: number) {
        this.Name = name;
        this.Price = price;
    }
}