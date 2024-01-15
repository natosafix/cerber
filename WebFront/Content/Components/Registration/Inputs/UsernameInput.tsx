import React from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import {BaseInput} from "./BaseInput"


function validate(value: string): Nullable<ValidationInfo> {
    if (value.length >= 100) {
        return { message: 'Не более 100 символов', type: 'submit' };
    }
    return null;
}

export const UsernameInput = ({ onChange }: { onChange: (value: string) => void }) => {
    return (
        <BaseInput type={"text"} validate={validate} placeholder={"Имя пользователя"} onChange={onChange} />
    );
};
