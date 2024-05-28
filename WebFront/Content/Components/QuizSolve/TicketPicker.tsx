import React, { useState } from 'react';
import { Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import styles from './QuizSolve.scss';
import { TicketDto } from '../../../Api/Models/TicketDto';
import { Label } from '../../Entries/Shared/Label/Label';
import variables from '../../Entries/Shared/Questions/QuestionVariables.scss';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';

interface TicketPickerProps {
    tickets: TicketDto[];
    onTicketChange: (id: number) => void;
}

function validateChosenTicket(value?: number): Nullable<ValidationInfo> {
    if (!value) {
        return { message: 'Поле обязательно для заполнения', type: 'submit' };
    }

    return null;
}

export const TicketPicker: React.FC<TicketPickerProps> = ({ tickets, onTicketChange }) => {
    const [value, setValue] = useState<number>();

    const onRadioChange = (v: number) => {
        setValue(v);
        onTicketChange(v);
    };

    return (
        <div className={styles.answerWrapper}>
            <Gapped vertical gap={Number.parseInt(variables.titleContentGap)}>
                <Label label={'Выбор билета'} size={'small'} />
                <ValidationWrapper validationInfo={validateChosenTicket(value)}>
                    <RadioGroup onValueChange={onRadioChange} value={value}>
                        <Gapped vertical gap={20}>
                            {tickets.map((ticket, index) => (
                                <Radio key={index} value={ticket.id}>
                                    <Gapped vertical gap={5}>
                                        {ticket.name}
                                        <div style={{ opacity: 0.5 }}>
                                            <Label label={`Стоимость: ${ticket.price}₽`} size={'tiny'} />
                                        </div>
                                    </Gapped>
                                </Radio>
                            ))}
                        </Gapped>
                    </RadioGroup>
                </ValidationWrapper>
            </Gapped>
        </div>
    );
};
