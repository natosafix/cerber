import * as React from 'react';
import { useEffect, useRef, useState } from 'react';
import { Answer } from '../../../Api/QuizSolve/Answer';
import { QuizSolveClient } from '../../../Api/QuizSolve/QuizSolveClient';
import styles from './QuizSolve.scss';
import { AnswerView } from './AnswerView';
import { Button } from '@skbkontur/react-ui';
import { TicketDto } from '../../../Api/Models/TicketDto';
import { TicketPicker } from './TicketPicker';
import { CreateAnswerDto } from '../../../Api/QuizSolve/CreateAnswerDto';
import { CreateOrderDto } from '../../../Api/QuizSolve/CreateOrderDto';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { EventAdminClient } from '../../../Api/EventAdmin/EventAdminClient';


export const QuizSolve: React.FC = () => {
    const location = window.location.href;
    const segments = location.split('/');
    const quizId = Number(segments[segments.length - 1]);

    const validWrapper = useRef<ValidationContainer>(null);

    const [answers, setAnswers] = useState<Answer[] | undefined>();
    const [tickets, setTickets] = useState<TicketDto[] | undefined>();
    const [chosenTicket, setChosenTicket] = useState<number>();


    useEffect(() => {
        QuizSolveClient.getQuestions(quizId).then((r) => {
            setAnswers(r.data.map(question => new Answer(question)));
        });

        QuizSolveClient.getTickets(quizId).then((r) => {
            setTickets(r.data);
        });
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
    };

    const onSendBtn = async () => {
        if (validWrapper.current) {
            const isValid = await validWrapper.current.validate();
            if (isValid) {
                const answerDtos = answers.map(ans => new CreateAnswerDto(ans.Content, ans.Question.id));
                const createOrderDto = new CreateOrderDto(chosenTicket!, answerDtos);

                await QuizSolveClient.createOrder(createOrderDto);
            }
        }
    };

    return (
        <ValidationContainer ref={validWrapper}>
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
        </ValidationContainer>
    );
};