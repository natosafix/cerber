import { CreateAnswerDto } from './CreateAnswerDto';

export class CreateOrderDto {
    public ticketId: number;
    public answers: CreateAnswerDto[];
    
    constructor(ticketId: number, answers: CreateAnswerDto[]) {
        this.ticketId = ticketId;
        this.answers = answers;
    }
}