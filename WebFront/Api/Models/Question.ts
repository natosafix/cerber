import { QuestionTypes } from './QuestionTypes';

export class Question {
    public key: number;
    public title: string;
    public type: QuestionTypes;
    public answerChoices: string[];

    constructor(key: number) {
        this.key = key;
        this.type = QuestionTypes.SingleString;
        this.answerChoices = [];
    }
    
    public withTitle(title: string): Question {
        this.title = title;
        return this;
    }
    
    public withType(type: QuestionTypes): Question {
        this.type = type;
        return this;
    }
    
    public withAnswerChoices(choices: string[]): Question {
        this.answerChoices = choices;
        return this;
    }
}