import * as React from 'react';
import { Answer } from '../../../Api/QuizSolve/Answer';
import styles from './QuizSolve.scss';
import { QuestionTypes } from '../../../Api/Models/QuestionTypes';
import { MultiStringQuestion } from '../../Entries/Shared/Questions/MultiStringQuestion';
import { SingleStringQuestion } from '../../Entries/Shared/Questions/SingleStringQuestion';
import { RadioPicker } from '../../Entries/Shared/Questions/RadioPicker';
import { CheckboxPicker } from '../../Entries/Shared/Questions/CheckboxPicker';

interface AnswerProps {
    answer: Answer;
    onAnswerChange: (answer: Answer) => void;
}

export const AnswerView: React.FC<AnswerProps> = ({ answer, onAnswerChange }) => {
    return (
        <div className={styles.answerWrapper}>
            {
                answer.Question.type === QuestionTypes.SingleString && (
                    <SingleStringQuestion title={answer.Question.title} 
                                          size={'small'} 
                                          onValueChange={(v) => onAnswerChange(answer.withContent([v]))}
                    />
                )
            }
            {
                answer.Question.type === QuestionTypes.MultiString && (
                    <MultiStringQuestion title={answer.Question.title} 
                                         size={'small'}
                                         onValueChange={(v) => onAnswerChange(answer.withContent([v]))}
                    />
                )
            }
            {
                answer.Question.type === QuestionTypes.OneSelection && (
                    <RadioPicker title={answer.Question.title} 
                                 variants={answer.Question.answerChoices} 
                                 size={'small'}
                                 onValueChange={(v) => onAnswerChange(answer.withContent([v]))}
                    />
                )
            }
            {
                answer.Question.type === QuestionTypes.MultipleSelection && (
                    <CheckboxPicker title={answer.Question.title} 
                                    variants={answer.Question.answerChoices} 
                                    size={'small'}
                                    onValueChange={(v) => onAnswerChange(answer.withContent(v))}
                    />
                )
            }
        </div>
    );
};