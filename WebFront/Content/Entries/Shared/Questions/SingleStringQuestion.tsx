import styles from './QuestionStyles.scss';
import variables from './QuestionVariables.scss';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Gapped, Input } from '@skbkontur/react-ui';
import React, { useState } from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { Label } from '../Label/Label';

interface Props {
    title: string;
    disabled?: boolean;
    placeholder?: string;
    size?: 'small' | 'medium' | 'large';
    onValueChange?: (value: string) => void;
    defaultValue?: string;
}

function isNullOrWhiteSpace(v: string) {
    return !v || v.trim() === '';
}

function validate(value: string): Nullable<ValidationInfo> {
    if (isNullOrWhiteSpace(value)) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    } else if (value.length >= 100) {
        return { message: 'Не более 100 символов', type: 'submit' };
    }

    return null;
}

export const SingleStringQuestion: React.FC<Props> = (
    {
        title,
        onValueChange = null,
        disabled = false,
        placeholder = '',
        size = 'large',
        defaultValue = '',
    },
) => {
    const [value, setValue] = useState(defaultValue);

    const changeValue = (v: string) => {
        setValue(v);
        if (onValueChange) {
            onValueChange(v);
        }
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <Label label={title} size={size} />
            <ValidationWrapper validationInfo={disabled ? null : validate(value)}>
                <Input className={styles.questionInput}
                       value={value}
                       onValueChange={changeValue}
                       placeholder={placeholder}
                       disabled={disabled}
                />
            </ValidationWrapper>
        </Gapped>
    );
};
