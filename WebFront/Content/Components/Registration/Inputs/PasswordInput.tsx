import React from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import {BaseInput} from "./BaseInput"


function validate(value: string): Nullable<ValidationInfo> {
    if (value.length < 6) {
        return { message: 'Минимальная длина - 6 символов', type: 'submit' };
    }

    if (value.includes(' ')) {
        return { message: 'Пробелы не разрешены', type: 'submit' };
    }

    if (!/\d/.test(value)) {
        return { message: 'Необходимо использовать хотя бы одну цифру', type: 'submit' };
    }

    if (!/[!@#$%^&*(),.?":{}|<>]/.test(value)) {
        return { message: 'Необходимо использовать хотя бы один спец символ', type: 'submit' };
    }

    if (!/[A-Z]/.test(value)) {
        return { message: 'Необходимо использовать хотя бы одну заглавную букву', type: 'submit' };
    }
    if (!/[a-z]/.test(value)) {
        return { message: 'Необходимо использовать хотя бы одну строчную букву', type: 'submit' };
    }
    if (value.length >= 100) {
        return { message: 'Не более 100 символов', type: 'submit' };
    }
    return null;
}

export const PasswordInput = ({ onChange }: { onChange: (value: string) => void }) => {
    return (
        <BaseInput type={"password"} validate={validate} placeholder={"Пароль"} onChange={onChange} />
    );
};
