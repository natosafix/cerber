export class DraftEvent
{
    public Id: number;
    public OwnerId: string;
    public Title: string;
    public Description: string;
    public City: string;
    public Address: string;
    public From: Date;
    public To: Date;
    
    public withTitle(title: string): DraftEvent {
        this.Title = title;
        return this;
    }
}