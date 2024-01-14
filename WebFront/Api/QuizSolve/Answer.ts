import { QuestionDto } from './QuestionDto';

export class Answer {
    public Content: string;
    public Question: QuestionDto;
    
    constructor(question: QuestionDto) {
        this.Question = question;
    }
}