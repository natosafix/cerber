import React, { useState } from 'react';
import { DatePicker, Gapped, Input } from '@skbkontur/react-ui';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { Label } from '../Label/Label';
import { Size } from '../../../Utility/Constants';
import { isNullOrWhiteSpace } from '../../../Utility/HelperFunctions';

interface Props {
    title: string;
    size?: Size;
    onValueChange: (value: Date) => void;
    defaultValue: Date | null;
}

function getDateStr(date: Date | null): string | undefined {
    if (!date) {
        return undefined;
    }

    const day = ('0' + date.getDate()).slice(-2);
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const year = date.getFullYear();

    return `${day}.${month}.${year}`;
}

function getTimeStr(date: Date | null): string | undefined {
    if (!date) {
        return undefined;
    }

    const hours = ('0' + date.getHours()).slice(-2);
    const minutes = ('0' + date.getMinutes()).slice(-2);

    return `${hours}:${minutes}`;
}

function validateTime(timeValue: string | undefined, dateTimeValue: Date | null): Nullable<ValidationInfo> {
    if (isNullOrWhiteSpace(timeValue)) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    }

    const fromDateTime = getTimeStr(dateTimeValue);
    if (timeValue !== fromDateTime) {
        return { message: 'Невалидное значение', type: 'submit' };
    }

    if (dateTimeValue! < new Date()) {
        return { message: 'Событие должно происходить в будущем', type: 'submit' };
    }

    return null;
}

function validateDate(dateValue: string | undefined, dateTimeValue: Date | null): Nullable<ValidationInfo> {
    if (isNullOrWhiteSpace(dateValue)) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    }

    const fromDateTime = getDateStr(dateTimeValue);
    if (dateValue !== fromDateTime) {
        return { message: 'Невалидное значение', type: 'submit' };
    }

    return null;
}

export const DateTimeQuestion: React.FC<Props> = ({ title, defaultValue, onValueChange, size = 'large' }) => {
    const [dateTimeValue, setDateTimeValue] = useState<Date>(defaultValue ?? new Date());
    const [dateValue, setDateValue] = useState(defaultValue === null ? '' : getDateStr(defaultValue));
    const [timeValue, setTimeValue] = useState(defaultValue === null ? '' : getTimeStr(defaultValue));

    const onDatePickerChange = (v: string) => {
        setDateValue(v);

        const [day, month, year] = v.split('.').map((i) => Number(i));
        const [hours, minutes] = timeValue?.split(':')?.map((i) => Number(i)) ?? [null, null];

        // @ts-ignore
        // пишет, что Date в часах и минутах принимает number | undefined, но это фейк, так дата не может распарситься
        // поэтому hours и minutes делаю number | null
        const newDate = new Date(year, month - 1, day, hours, minutes);
        if (!newDate.valueOf()) {
            return;
        }

        setDateTimeValue(newDate);
        onValueChange(newDate);
    };

    const onTimeChange = (v: string) => {
        setTimeValue(v);

        if (!dateTimeValue) {
            return;
        }
        const [hours, minutes] = v.split(':').map((i) => Number(i));

        const year = dateTimeValue.getFullYear();
        const month = dateTimeValue.getMonth();
        const day = dateTimeValue.getDate();

        const newDate = new Date(year, month, day, hours, minutes);
        if (!newDate.valueOf()) {
            return;
        }

        setDateTimeValue(newDate);
        onValueChange(newDate);
    };

    return (
        <Gapped vertical={true}>
            <Label label={title} size={size} />
            <Gapped>
                <ValidationWrapper validationInfo={validateDate(dateValue, dateTimeValue)}>
                    <DatePicker
                        value={dateValue}
                        onValueChange={onDatePickerChange}
                        minDate={getDateStr(new Date())}
                        width="auto"
                    />
                </ValidationWrapper>
                <ValidationWrapper validationInfo={validateTime(timeValue, dateTimeValue)}>
                    <Input value={timeValue} onValueChange={onTimeChange} type={'time'} width={100} />
                </ValidationWrapper>
            </Gapped>
        </Gapped>
    );
};
