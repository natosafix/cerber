import * as React from 'react';
import { Answer } from '../../../Api/QuizSolve/Answer';

interface AnswerProps {
    answer: Answer;
}

export const AnswerView: React.FC<AnswerProps> = ({ answer }) => {

    return (
        <>
            {answer.Question.title}<br/>
            {answer.Question.answerChoices}<br/>
            {answer.Question.type}<br/>
        </>
    );
};