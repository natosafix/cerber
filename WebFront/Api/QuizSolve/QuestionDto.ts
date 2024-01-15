import { QuestionTypes } from '../Models/QuestionTypes';

export class QuestionDto {
    public id: number;
    public title: string;
    public type: QuestionTypes;
    public answerChoices: string[];
}