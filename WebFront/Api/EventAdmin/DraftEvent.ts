import { IEvent } from '../../Content/Components/EventPreview/Models/IEvent';
import { EventAdminClient } from './EventAdminClient';

export class DraftEvent {
    public CoverImageId: number;
    public Title: string;
    public Description: string;
    public City: string;
    public Address: string;
    public From: Date | null;
    public To: Date;

    constructor(
        coverImageId: number,
        title: string,
        description: string,
        city: string,
        address: string,
        from: Date | null,
        to: Date,
    ) {
        this.CoverImageId = coverImageId;
        this.Title = title;
        this.Description = description;
        this.City = city;
        this.Address = address;
        this.From = from;
        this.To = to;
    }

    public static fromDto(dto: DraftEventDto): DraftEvent {
        return new DraftEvent(
            dto.coverImageId,
            dto.title,
            dto.description,
            dto.city,
            dto.address,
            dto.from ? new Date(dto.from) : null,
            new Date(dto.to),
        );
    }

    public withTitle(title: string): DraftEvent {
        this.Title = title;
        return this;
    }

    public withAddress(address: string): DraftEvent {
        this.Address = address;
        return this;
    }

    public withCity(city: string): DraftEvent {
        this.City = city;
        return this;
    }

    public withDescription(description: string): DraftEvent {
        this.Description = description;
        return this;
    }

    public withFrom(value: Date): DraftEvent {
        this.From = value;
        return this;
    }

    public async toIEvent(): Promise<IEvent> {
        return {
            name: this.Title,
            description: this.Description,
            address: this.Address,
            city: this.City,
            from: this.From,
            img: await EventAdminClient.getCoverImage(),
        } as IEvent;
    }
}

export class DraftEventDto {
    public coverImageId: number;
    public title: string;
    public description: string;
    public city: string;
    public address: string;
    public from: string;
    public to: string;
}
