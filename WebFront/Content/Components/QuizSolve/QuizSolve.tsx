import * as React from 'react';
import { useEffect, useState } from 'react';
import { Answer } from '../../../Api/QuizSolve/Answer';
import { QuizSolveClient } from '../../../Api/QuizSolve/QuizSolveClient';
import styles from './QuizSolve.scss';
import { AnswerView } from './AnswerView';
import { Button } from '@skbkontur/react-ui';
import { TicketDto } from '../../../Api/Models/TicketDto';
import { TicketPicker } from './TicketPicker';


export const QuizSolve: React.FC = () => {
    const location = window.location.href;
    const segments = location.split('/');
    const quizId = Number(segments[segments.length - 1]);
    
    const [answers, setAnswers] = useState<Answer[] | undefined>();
    const [tickets, setTickets] = useState<TicketDto[] | undefined>();
    const [chosenTicket, setChosenTicket] = useState<number>();
    

    useEffect(() => {
        QuizSolveClient.getQuestions(quizId).then((r) => {
            setAnswers(r.data.map(question => new Answer(question)))
        })
        
        QuizSolveClient.getTickets(quizId).then((r)=> {
            setTickets(r.data);
        })
    }, []);
    
    if (!answers || !tickets) {
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

                <TicketPicker tickets={tickets!} onTicketChange={setChosenTicket} />
                
                <div style={{ width: '100%' }}>
                    <Button use={'primary'} onClick={onSendBtn}>
                        Отправить
                    </Button>
                </div>
            </div>
        </div>
    );
}