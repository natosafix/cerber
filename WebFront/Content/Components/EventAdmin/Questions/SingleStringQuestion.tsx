﻿import styles from '../EventAdmin.scss';
import variables from '../EventAdminVariables.scss';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Gapped, Input } from '@skbkontur/react-ui';
import React, { useEffect, useState } from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { Label } from '../../../Entries/Shared/Label/Label';

interface Props {
    storageSaver?: ILocalStorageSaver;
    title: string;
    disabled?: boolean;
    placeholder?: string;
    size?: "small" | "medium" | "large";
    onValueChange?: (string) => void;
    defaultValue?: string;
}

function validate(value: string): Nullable<ValidationInfo> {
    if (value === null || value.length == 0) {
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
        storageSaver = null,
        disabled = false,
        placeholder= '',
        size= "large",
        defaultValue = ''
    },
) => {
    const [value, setValue] = useState(defaultValue);
    
    const changeValue = (v: string) => {
        setValue(v);
        if (onValueChange) {
            onValueChange(v);
        }
    }

    useEffect(() => {
        let savedValue = storageSaver?.load(title);
        if (savedValue && savedValue !== value) {
            changeValue(savedValue);
        }
    }, []);

    let saveStorage = () => {
        storageSaver?.save(title, value);
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <Label label={title} size={size} />
            <ValidationWrapper validationInfo={validate(value)}>
                <Input className={styles.questionInput}
                       value={value} 
                       onValueChange={changeValue} 
                       onBlur={saveStorage}
                       placeholder={placeholder}
                       disabled={disabled} />
            </ValidationWrapper>
        </Gapped>
    );
};

SingleStringQuestion.defaultProps = {
    placeholder: '',
    disabled: false
};