﻿import React, { useState } from 'react';
import { QuestionTypePicker } from './QuestionTypePicker';
import { Label } from '../../../../Entries/Shared/Label/Label';
import { Gapped } from '@skbkontur/react-ui';
import { ChoicesCreator } from './ChoicesCreator';
import styles from './QuestionBuilder.scss';
import { Question } from '../../../../../Api/Models/Question';
import { QuestionTypes } from '../../../../../Api/Models/QuestionTypes';
import { SingleStringQuestion } from '../../../../Entries/Shared/Questions/SingleStringQuestion';

interface Props {
    question: Question;
    onQuestionUpdate: (question: Question) => void;
    questionNum: number;
}

export const QuestionBuilder: React.FC<Props> = ({ question, onQuestionUpdate, questionNum }) => {
    const [type, setType] = useState(question.type);

    const onTitleUpdate = (v: string) => {
        onQuestionUpdate(question.withTitle(v));
    };

    const onTypeChange = (type: QuestionTypes) => {
        setType(type);
        onQuestionUpdate(question.withType(type));
    };

    const onChoicesChange = (choices: string[]) => {
        onQuestionUpdate(question.withAnswerChoices(choices));
    };

    return (
        <Gapped gap={10} vertical={true}>
            <Label label={`Вопрос №${questionNum}`} size={'medium'} />
            <SingleStringQuestion title={'Текст вопроса'} size={'small'}
                                  onValueChange={onTitleUpdate}
                                  defaultValue={question.title} />
            <QuestionTypePicker onValueChange={onTypeChange} defaultValue={type} />
            {(type === QuestionTypes.OneSelection || type === QuestionTypes.MultipleSelection) && (
                <div className={styles.choicesCreatorWrapper}>
                    <ChoicesCreator srcChoices={question.answerChoices} setSrcChoices={onChoicesChange} />
                </div>
            )}
        </Gapped>
    );
};
