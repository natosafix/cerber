import * as React from 'react';
import { useEffect, useState } from 'react';
import { Answer } from '../../../Api/QuizSolve/Answer';
import { QuizSolveClient } from '../../../Api/QuizSolve/QuizSolveClient';
import styles from '../EventAdmin/EventQuizCreator/EventQuizCreator.scss';
import { BinButton } from '../../Entries/Shared/BinButton/BinButton';
import { QuestionBuilder } from '../EventAdmin/Questions/QuestionBuilder/QuestionBuilder';
import { Question } from '../../../Api/Models/Question';
import { AnswerView } from './AnswerView';


export const QuizSolve: React.FC = () => {
    const location = window.location.href;
    const segments = location.split('/');
    const quizId = Number(segments[segments.length - 1]);
    
    const [answers, setAnswers] = useState<Answer[] | undefined>();

    useEffect(() => {
        QuizSolveClient.getQuestions(quizId).then((r) => {
            setAnswers(r.data.map(question => new Answer(question)))
        })
    }, []);
    
    if (!answers) {
        return (
            <>
                Загрузка
            </>
        );
    }
    
    return (
        <>
            {answers.map((answer) => (<AnswerView answer={answer} />))}
        </>
    );
}