import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Gapped, Input } from '@skbkontur/react-ui';
import {InputType} from '@skbkontur/react-ui'
import React, { useEffect, useState } from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';

interface Props {
    placeholder?: string;
    defaultValue?: string;
    type: InputType;
    validate?: (value: string) => Nullable<ValidationInfo>;
    onChange: (value: string) => void;
}

function isNullOrWhiteSpace(v: string) {
    return !v || v.trim() === '';
}

function baseValidate(value: string, validate?: (value: string) => Nullable<ValidationInfo>): Nullable<ValidationInfo> {
    if (isNullOrWhiteSpace(value)) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    }
    return (validate ?? (() => null))(value);
}


export const BaseInput: React.FC<Props> = (
    {
        defaultValue = '',
        placeholder =  '',
        type,
        validate,
        onChange
    },
) => {
    const [value, setValue] = useState(defaultValue);

    const changeValue = (v: string) => {
        setValue(v);
        onChange(v);
    };

    return (
        <Gapped vertical={true}>
            <ValidationWrapper validationInfo={baseValidate(value, validate)}>
                <Input
                    type={type}
                    width={350}
                    size={"large"}
                    value={value}
                    onValueChange={changeValue}
                    placeholder={placeholder}
                />
            </ValidationWrapper>
        </Gapped>
    );
};
