import React from 'react';
import { Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import variables from './QuestionVariables.scss';
import { Label } from '../Label/Label';

interface RadioPickerProps {
    title: string;
    variants: string[];
    size?: 'small' | 'medium' | 'large';
    onValueChange: (picked: string) => void;
}

export const RadioPicker: React.FC<RadioPickerProps> = (
    {
        variants, 
        title,
        size = 'large',
        onValueChange
    }) => {
    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <Label label={title} size={size} />
            <RadioGroup onValueChange={onValueChange}>
                <Gapped gap={5} vertical={true}>
                    {variants.map((variant, i) => (
                        <Radio value={variant} size={size}>
                            {variant}
                        </Radio>
                    ))}
                </Gapped>
            </RadioGroup>
        </Gapped>
    );
};