import React, { useState } from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';
import { SingleStringQuestion } from '../Questions/SingleStringQuestion';
import { LocalStorageSaver } from '../../../Helpers/LocalStorageSaver/LocalStorageSaver';
import { Button, Gapped } from '@skbkontur/react-ui';
import { QuestionBuilder } from '../Questions/QuestionBuilder/QuestionBuilder';
import { Question } from '../Questions/QuestionBuilder/Question';

interface Props {
    onSave: () => void;
}

export const EventQuizCreator: React.FC<Props> = ({ onSave }) => {
    let localStorageSaver = new LocalStorageSaver('Draft.Quiz');
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

    const Create: React.FC<Question> = (question) => {
        return (
            <div key={question.key}>
                <Button onClick={() => onDeleteQuestion(question.key)}>Удалить</Button>
                <QuestionBuilder storageSaver={localStorageSaver} 
                                 onQuestionUpdate={onUpdateQuestion}
                                 question={question} />
            </div>
        );
    };

    return (
        <Gapped gap={40} vertical={true}>
            <Button borderless={true} onClick={onAddQuestion}>Добавить вопрос</Button>
            <SingleStringQuestion storageSaver={localStorageSaver}
                                  title={'Вопрос №1'}
                                  disabled={true}
                                  placeholder={'Введите ваш Email'}
                                  size={'medium'}
            />
            <SingleStringQuestion storageSaver={localStorageSaver}
                                  title={'Вопрос №2'}
                                  disabled={true}
                                  placeholder={'Введите ваше имя'}
                                  size={'medium'}
            />
            <SingleStringQuestion storageSaver={localStorageSaver}
                                  title={'Вопрос №3'}
                                  disabled={true}
                                  placeholder={'Введите вашу фамилию'}
                                  size={'medium'}
            />
            {questions.map((question) =>
                Create(question),
            )}
            <EventAdminSaveBtn onSave={onSave} />
        </Gapped>
    );
};