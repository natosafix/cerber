import * as React from 'react';
import { useEffect, useState } from 'react';
import { Answer } from '../../../Api/QuizSolve/Answer';
import { QuizSolveClient } from '../../../Api/QuizSolve/QuizSolveClient';
import styles from './QuizSolve.scss';
import { AnswerView } from './AnswerView';
import { Button } from '@skbkontur/react-ui';


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
    
    const onAnswerChange = (answer: Answer, id: number) => {
        answers[id] = answer;
        setAnswers([...answers]);
    }
    
    const onSendBtn = () => {
        alert(JSON.stringify(answers));
    }
    
    return (
        <div className={styles.pageWrapper}>
            <div className={styles.answersWrapper}>
                {answers.map((answer, id) => (
                    <AnswerView key={id}
                                answer={answer}
                                onAnswerChange={(ans) => onAnswerChange(ans, id)}
                    />
                ))}
                
                <div style={{ width: '100%' }}>
                    <Button use={'primary'} onClick={onSendBtn}>
                        Отправить
                    </Button>
                </div>
            </div>
        </div>
    );
}