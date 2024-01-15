import React, { useState } from 'react';
import { Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import variables from './QuestionVariables.scss';
import { Label } from '../Label/Label';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';

interface RadioPickerProps {
    title: string;
    variants: string[];
    size?: 'small' | 'medium' | 'large';
    onValueChange: (picked: string) => void;
}

function validateChosenVariant(value?: string): Nullable<ValidationInfo> {
    if (!value || value.length === 0) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    }

    return null;
}

export const RadioPicker: React.FC<RadioPickerProps> = (
    {
        variants,
        title,
        size = 'large',
        onValueChange,
    }) => {
    const [value, setValue] = useState<string>();

    const onRadioChange = (v: string) => {
        setValue(v);
        onValueChange(v);
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <Label label={title} size={size} />
            <ValidationWrapper validationInfo={validateChosenVariant(value)}>
                <RadioGroup onValueChange={onRadioChange} value={value}>
                    <Gapped gap={5} vertical={true}>
                        {variants.map((variant, i) => (
                            <Radio value={variant} size={size}>
                                {variant}
                            </Radio>
                        ))}
                    </Gapped>
                </RadioGroup>
            </ValidationWrapper>
        </Gapped>
    );
};