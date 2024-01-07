export class DraftEvent {
    public Id: number;
    public OwnerId: string;
    public Title: string;
    public Description: string;
    public City: string;
    public Address: string;
    public From: Date;
    public To: Date;

    constructor(id: number, ownerId: string, title: string, description: string, city: string, address: string, from: Date, to: Date) {
        this.Id = id;
        this.OwnerId = ownerId;
        this.Title = title;
        this.Description = description;
        this.City = city;
        this.Address = address;
        this.From = from;
        this.To = to;
    }

    public static fromDto(dto: DraftEventDto): DraftEvent {
        return new DraftEvent(dto.id, dto.ownerId, dto.title, dto.description, dto.city, dto.address, dto.from, dto.to);
    }

    public withTitle(title: string): DraftEvent {
        this.Title = title;
        return this;
    }

    public withDescription(description: string): DraftEvent {
        this.Description = description;
        return this;
    }
}

export class DraftEventDto {
    public id: number;
    public ownerId: string;
    public title: string;
    public description: string;
    public city: string;
    public address: string;
    public from: Date;
    public to: Date;
}