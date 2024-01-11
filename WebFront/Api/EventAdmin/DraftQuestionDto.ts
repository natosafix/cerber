import {QuestionTypes} from "../../Content/Components/EventAdmin/Questions/QuestionBuilder/QuestionTypes";

export class DraftQuestionDto {
    public title: string;
    public type: QuestionTypes;
    public answerChoices: string[];

    constructor(title: string, type: QuestionTypes, answerChoices: string[]) {
        this.title = title;
        this.type = type;
        this.answerChoices = answerChoices;
    }
}