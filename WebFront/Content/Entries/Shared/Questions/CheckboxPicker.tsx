import React, { useEffect, useRef, useState } from 'react';
import { Checkbox, Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import variables from './QuestionVariables.scss';
import { Label } from '../Label/Label';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';

interface CheckboxPickerProps {
    title: string;
    variants: string[];
    size?: 'small' | 'medium' | 'large';
    onValueChange: (checked: string[]) => void;
}

function validateChosen(checked: number[]): Nullable<ValidationInfo> {
    if (!checked || checked.length === 0) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    }

    return null;
}

export const CheckboxPicker: React.FC<CheckboxPickerProps> = (
    {
        variants,
        title,
        size = 'large',
        onValueChange,
    }) => {
    const [checked, setChecked] = useState<number[]>([]);

    let checkboxRefs = variants.map(_ => useRef<Checkbox | null>(null));
    let checkboxInstances = variants.map(_ => React.useRef<Checkbox>(null));

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

        // Нет аналогии с RadioGroup (какого-нибудь CheckboxGroup),
        // из-за чего нельзя валидировать целую группу чекбоксов.
        // Валидация происходит повторно при потере фокуса внутреннего объекта
        // Так мы принудительно забираем фокус нажатого чекбокса, остальные
        // тоже перестают гореть
        checkboxInstances[id].current!.blur();
    };

    useEffect(() => {
        onValueChange(checked.map((checkedId) => variants[checkedId]));
    }, [checked]);

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true}>
            <Label label={title} size={size} />
            <Gapped gap={5} vertical={true}>
                {variants.map((variant, i) => (
                    <ValidationWrapper validationInfo={validateChosen(checked)}>
                        <Checkbox key={i}
                                  ref={checkboxInstances[i]}
                                  checked={checked.includes(i)}
                                  value={variant}
                                  onValueChange={(v) => changeChecked(v, i)}
                                  size={size}
                        >
                            {variant}
                        </Checkbox>
                    </ValidationWrapper>
                ))}
            </Gapped>
        </Gapped>
    );
};