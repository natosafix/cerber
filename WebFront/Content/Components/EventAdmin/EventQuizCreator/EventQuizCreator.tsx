import React, {useEffect, useState} from 'react';
import {EventAdminSaveBtn} from '../EventStepsNav/EventAdminSaveBtn';
import {SingleStringQuestion} from '../Questions/SingleStringQuestion';
import {Button, Gapped} from '@skbkontur/react-ui';
import {QuestionBuilder} from '../Questions/QuestionBuilder/QuestionBuilder';
import {Question} from '../Questions/QuestionBuilder/Question';
import {BinButton} from '../../../Entries/Shared/BinButton/BinButton';
import styles from './EventQuizCreator.scss'
import {EventAdminClient} from "../../../../Api/EventAdmin/EventAdminClient";
import {DraftQuestionDto} from "../../../../Api/EventAdmin/DraftQuestionDto";

interface Props {
    onSave: () => void;
}

interface QuizBuilderCreatorProps {
    question: Question;
    num: number;
}

export const EventQuizCreator: React.FC<Props> = ({onSave}) => {
    const [questions, setQuestions] = useState<Question[] | undefined>();
    const [questionCounter, setQuestionCounter] = useState(0);

    useEffect(() => {
        EventAdminClient.getQuestions().then(response => {
            let questionsDto = response.data;
            if (!questionsDto) {
                setQuestions([])
                return;
            }
            setQuestionCounter(questionsDto.length);
            setQuestions(questionsDto.map((dto, idx) =>
                new Question(idx)
                    .withType(dto.type)
                    .withTitle(dto.title)
                    .withAnswerChoices(dto.answerChoices)));
        })
    }, []);

    if (!questions) {
        return null;
    }

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

    const onSaveBtnClick = async () => {
        let dtos = questions.map(q => new DraftQuestionDto(q.title, q.type, q.answerChoices));
        await EventAdminClient.setQuestions(dtos);
        onSave();
    }

    const Create: React.FC<QuizBuilderCreatorProps> = ({question, num}) => {
        return (
            <div key={question.key} className={styles.questionBuilderWrapper}>
                <div className={styles.binBtnWrapper}>
                    <BinButton onClick={() => onDeleteQuestion(question.key)}/>
                </div>
                <QuestionBuilder onQuestionUpdate={onUpdateQuestion}
                                 question={question}
                                 questionNum={num + 4}/>
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
            <EventAdminSaveBtn onSave={onSaveBtnClick}/>
        </Gapped>
    );
};