import React, { useState } from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';
import { SingleStringQuestion } from '../Questions/SingleStringQuestion';
import { LocalStorageSaver } from '../../../Helpers/LocalStorageSaver/LocalStorageSaver';
import { Button, Gapped } from '@skbkontur/react-ui';
import { QuestionBuilder } from '../Questions/QuestionBuilder/QuestionBuilder';
import { Question } from '../Questions/QuestionBuilder/Question';
import { BinButton } from '../../../Entries/Shared/BinButton/BinButton';
import styles from './EventQuizCreator.scss'

interface Props {
    onSave: () => void;
}

interface QuizBuilderCreatorProps {
    question: Question;
    num: number;
}

export const EventQuizCreator: React.FC<Props> = ({ onSave }) => {
    const [questions, setQuestions] = useState<Question[]>([]);
    const [questionCounter, setQuestionCounter] = useState(0);

    const onAddQuestion = () => {
        setQuestions([...questions, new Question(questionCounter)]);
        setQuestionCounter(questionCounter + 1);
    };

    const onDeleteQuestion = (key: number) => {
        setQuestions(questions.filter((q) => q.key !== key));
    };

    const onUpdateQuestion = (question: Question) => {
        let idx = questions.findIndex((v) => v.key == question.key);
        questions[idx] = question;
        setQuestions(questions);
    };

    const Create: React.FC<QuizBuilderCreatorProps> = ({question, num}) => {
        return (
            <div key={question.key} className={styles.questionBuilderWrapper}>
                <div className={styles.binBtnWrapper}>
                    <BinButton onClick={() => onDeleteQuestion(question.key)} />
                </div>
                <QuestionBuilder onQuestionUpdate={onUpdateQuestion}
                                 question={question}
                                 questionNum={num + 4} />
            </div>
        );
    };

    return (
        <Gapped gap={40} vertical={true}>
            <Button borderless={true} onClick={onAddQuestion}>Добавить вопрос</Button>
            <SingleStringQuestion title={'Вопрос №1'}
                                  disabled={true}
                                  placeholder={'Введите ваш Email'}
                                  size={'medium'}
            />
            <SingleStringQuestion title={'Вопрос №2'}
                                  disabled={true}
                                  placeholder={'Введите ваше имя'}
                                  size={'medium'}
            />
            <SingleStringQuestion title={'Вопрос №3'}
                                  disabled={true}
                                  placeholder={'Введите вашу фамилию'}
                                  size={'medium'}
            />
            {questions.map((question, num) =>
                Create({question, num})
            )}
            <EventAdminSaveBtn onSave={onSave} />
        </Gapped>
    );
};