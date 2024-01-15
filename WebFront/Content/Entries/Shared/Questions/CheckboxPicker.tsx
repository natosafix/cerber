import React, { useEffect, useState } from 'react';
import { Checkbox, Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import variables from './QuestionVariables.scss';
import { Label } from '../Label/Label';

interface CheckboxPickerProps {
    title: string;
    variants: string[];
    size?: 'small' | 'medium' | 'large';
    onValueChange: (checked: string[]) => void;
}

export const CheckboxPicker: React.FC<CheckboxPickerProps> = (
    { 
        variants, 
        title, 
        size = 'large',
        onValueChange
    }) => {
    const [checked, setChecked] = useState<number[]>([]);
    
    const changeChecked = (v: boolean, id: number) => {
        const checkedIdx = checked.indexOf(id);

        if (checkedIdx === -1) {
            setChecked((prev) => [...prev, id]);
        } else {
            setChecked((prev) =>
                prev.filter((siblingId) => {
                    return siblingId !== id;
                }),
            );
        }
    }

    useEffect(() => {
        onValueChange(checked.map((checkedId) => variants[checkedId]));
    }, [checked]);
    
    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <Label label={title} size={size} />
            <Gapped gap={5} vertical={true}>
                {variants.map((variant, i) => (
                    <Checkbox key={i}
                              checked={checked.includes(i)}
                              value={variant}
                              onValueChange={(v) => changeChecked(v, i)}
                              size={size}
                    >
                        {variant}
                    </Checkbox>
                ))}
            </Gapped>
        </Gapped>
    );
};