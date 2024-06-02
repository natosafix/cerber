import React from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import {BaseInput} from "./BaseInput"
import { ValidationMessages } from '../../../Utility/Constants';


function validate(value: string): Nullable<ValidationInfo> {
    if (value.length >= 100) {
        return { message: ValidationMessages.OneHundredCharactersLimit, type: 'submit' };
    }
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(value)) {
         return { message: 'Некорректный формат email', type: 'submit' };
    }
    
    return null;
}

export const EmailInput = ({ onChange }: { onChange: (value: string) => void }) => {
    return (
        <BaseInput type={"email"} validate={validate} placeholder={"Email"} onChange={onChange} />
    );
};
