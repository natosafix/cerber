import React from 'react';
import { Gapped, Radio, RadioGroup } from '@skbkontur/react-ui';
import styles from './QuizSolve.scss';
import { TicketDto } from '../../../Api/Models/TicketDto';
import { Label } from '../../Entries/Shared/Label/Label';
import variables from '../../Entries/Shared/Questions/QuestionVariables.scss';

interface TicketPickerProps {
    tickets: TicketDto[];
    onTicketChange: (id: number) => void;
}

export const TicketPicker: React.FC<TicketPickerProps> = ({ tickets, onTicketChange }) => {
    return (
        <div className={styles.answerWrapper}>
            <Gapped vertical gap={Number.parseInt(variables.titleContentGap)}>
                <Label label={'Выбор билета'} size={'small'} />
                <RadioGroup onValueChange={onTicketChange}>
                    <Gapped vertical gap={20}>
                        {tickets.map((ticket) => (
                            <Radio value={ticket.id}>
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
            </Gapped>
        </div>
    );
};