export class CreateAnswerDto {
    public content: string[];
    public questionId: number;

    constructor(content: string[], questionId: number) {
        this.content = content;
        this.questionId = questionId;
    }
}