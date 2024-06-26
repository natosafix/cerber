﻿import React, { useState } from 'react';
import { Button, Gapped, Input } from '@skbkontur/react-ui';
import { Label } from '../../../../Entries/Shared/Label/Label';
import styles from './QuestionBuilder.scss';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { isNullOrWhiteSpace } from '../../../../Utility/HelperFunctions';
import { ValidationMessages } from '../../../../Utility/Constants';

interface Props {
    srcChoices: string[];
    setSrcChoices: (string: string[]) => void;
}

function validate(value: string): Nullable<ValidationInfo> {
    if (isNullOrWhiteSpace(value)) {
        return { message: ValidationMessages.FieldRequired, type: 'submit' };
    } else if (value.length >= 100) {
        return { message: ValidationMessages.OneHundredCharactersLimit, type: 'submit' };
    }

    return null;
}

function validateChoicesExists(choices: string[]): Nullable<ValidationInfo> {
    if (!choices || choices.length === 0) {
        return { message: 'Требуется хотя бы один варинат ответа', type: 'submit' };
    }

    return null;
}

export const ChoicesCreator: React.FC<Props> = ({ srcChoices, setSrcChoices }) => {
    const [choices, setChoices] = useState(srcChoices);

    const onRemove = (idx: number) => {
        let newChoices = choices.filter((c, i) => i !== idx);
        setSrcChoices(newChoices);
        setChoices(newChoices);
    };

    const onAdd = () => {
        let newChoices = [...choices, ''];
        setSrcChoices(newChoices);
        setChoices(newChoices);
    };

    const onValueChange = (value: string, idx: number) => {
        choices[idx] = value;
        setSrcChoices(choices);
        setChoices([...choices]);
    };

    return (
        <Gapped vertical={true}>
            <Label label={'Варианты ответа'} size={'small'} />
            {choices.map((choice, i) => (
                <div key={i} className={styles.lineWrapper}>
                    <ValidationWrapper validationInfo={validate(choice)}>
                        <Input
                            size={'small'}
                            className={styles.input}
                            value={choice}
                            onValueChange={(v) => onValueChange(v, i)}
                        />
                    </ValidationWrapper>
                    <div className={styles.deleteBtnWrapper}>
                        <Button use={'text'} borderless={true} size={'small'} onClick={() => onRemove(i)}>
                            Удалить вариант
                        </Button>
                    </div>
                </div>
            ))}
            <ValidationWrapper validationInfo={validateChoicesExists(choices)}>
                <Button use={'default'} onClick={onAdd}>
                    Добавить
                </Button>
            </ValidationWrapper>
        </Gapped>
    );
};
