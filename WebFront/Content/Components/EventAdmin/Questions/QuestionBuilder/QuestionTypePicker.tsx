import React from 'react';
import { Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import { QuestionTypes } from '../../../../../Api/Models/QuestionTypes';

interface Props {
    onValueChange: (QuestionTypes) => void;
    defaultValue?: QuestionTypes;
}

export const QuestionTypePicker: React.FC<Props> = ({ onValueChange, defaultValue = QuestionTypes.SingleString }) => {
    return (
        <RadioGroup defaultValue={defaultValue} onValueChange={onValueChange}>
            <Gapped gap={5} vertical={true}>
                <Radio value={QuestionTypes.SingleString}>Короткий ответ</Radio>
                <Radio value={QuestionTypes.MultiString}>Длинный ответ</Radio>
                <Radio value={QuestionTypes.OneSelection}>Выбор одного варианта</Radio>
                <Radio value={QuestionTypes.MultipleSelection}>Выбор нескольких вариантов</Radio>
            </Gapped>
        </RadioGroup>
    );
};