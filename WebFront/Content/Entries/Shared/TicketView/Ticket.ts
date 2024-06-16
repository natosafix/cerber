﻿export class Ticket {
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