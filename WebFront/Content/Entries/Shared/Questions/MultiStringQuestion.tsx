import styles from './QuestionStyles.scss';
import variables from './QuestionVariables.scss';
import { Gapped, Textarea } from '@skbkontur/react-ui';
import React, { useState } from 'react';
import { Label } from '../Label/Label';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { Size, ValidationMessages } from '../../../Utility/Constants';
import { isNullOrWhiteSpace } from '../../../Utility/HelperFunctions';

interface IMultiStringQuestion {
    title: string;
    size?: Size;
    onValueChange?: (value: string) => void;
    defaultValue?: string;
}

function validate(value: string): Nullable<ValidationInfo> {
    if (isNullOrWhiteSpace(value)) {
        return { message: ValidationMessages.FieldRequired, type: 'submit' };
    }

    return null;
}

export const MultiStringQuestion: React.FC<IMultiStringQuestion> = ({
    title,
    size = 'large',
    onValueChange = null,
    defaultValue = '',
}) => {
    const [value, setValue] = useState(defaultValue ?? '');

    const changeValue = (v: string) => {
        setValue(v);
        onValueChange && onValueChange(v);
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true} className={styles.questionInput}>
            <Label label={title} size={size} />
            <ValidationWrapper validationInfo={validate(value)}>
                <Textarea width={'100%'} value={value} onValueChange={changeValue} maxRows={50} autoResize={true} />
            </ValidationWrapper>
        </Gapped>
    );
};
