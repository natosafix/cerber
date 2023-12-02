import styles from '../EventAdmin.scss';
import variables from '../EventAdminVariables.scss';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Gapped, Input } from '@skbkontur/react-ui';
import React, { useEffect, useState } from 'react';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';

interface ISingleStringQuestion {
    storageSaver: ILocalStorageSaver;
    title: string;
}

function validate(value: string): Nullable<ValidationInfo> {
    if (value === null || value.length == 0) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    } else if (value.length >= 100) {
        return { message: 'Не более 100 символов', type: 'submit' };
    }

    return null;
}

export const SingleStringQuestion: React.FC<ISingleStringQuestion> = ({ title, storageSaver }) => {
    const [value, setValue] = useState('');

    useEffect(() => {
        let savedValue = storageSaver.load(title);
        if (savedValue && savedValue !== value) {
            setValue(savedValue);
        }
    }, []);

    let saveStorage = () => {
        storageSaver.save(title, value);
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <div className={styles.questionLabel}>{title}</div>
            <ValidationWrapper validationInfo={validate(value)}>
                <Input className={styles.questionInput} value={value} onValueChange={setValue} onBlur={saveStorage} />
            </ValidationWrapper>
        </Gapped>
    );
};