import React, { useState } from 'react';
import { SingleStringQuestion } from '../SingleStringQuestion';
import { QuestionTypePicker } from './QuestionTypePicker';
import { Label } from '../../../../../Entries/Shared/Label/Label';
import { Gapped } from '@skbkontur/react-ui';
import { QuestionTypes } from './QuestionTypes';
import { Question } from './Question';

interface Props {
    storageSaver: ILocalStorageSaver;
    question: Question;
    onQuestionUpdate: (Question) => void;
}

export const QuestionBuilder: React.FC<Props> = ({ storageSaver, question, onQuestionUpdate }) => {
    const [type, setType] = useState(question.type);
    
    const onTitleUpdate = (v: string) => {
        onQuestionUpdate(question.withTitle(v));
    };
    
    const onTypeChange = (type: QuestionTypes) => {
        setType(type);
        onQuestionUpdate(question.withType(type));
    };
    
    return (
        <Gapped gap={10} vertical={true}>
            <Label label={`Вопрос №${question.key}`} size={'medium'} />
            <SingleStringQuestion title={'Текст вопроса'} size={'small'} onValueChange={onTitleUpdate} defaultValue={question.title} />
            <QuestionTypePicker onValueChange={onTypeChange} defaultValue={question.type} />
            {type === QuestionTypes.OneSelection && (
                <Label label={'Один из нескольких'} />
            )}
            {type === QuestionTypes.MultipleSelection && (
                <Label label={'Несколько из нескольких'} />
            )}
        </Gapped>
    );
};