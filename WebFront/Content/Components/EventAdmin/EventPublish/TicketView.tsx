import React from 'react';
import { Ticket } from './Ticket';
import { SingleStringQuestion } from '../../../Entries/Shared/Questions/SingleStringQuestion';
import { CurrencyInput, Gapped, Input } from '@skbkontur/react-ui';
import { Label } from '../../../Entries/Shared/Label/Label';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';

interface TicketViewProps {
    ticket: Ticket;
    ticketNum: number;
    onTicketChange: (ticket: Ticket) => void;
}

export const TicketView: React.FC<TicketViewProps> = ({ ticket, ticketNum, onTicketChange }) => {
    const onChangeTicketName = (v: string) => {
        onTicketChange(ticket.withName(v));
    }

    const onChangeTicketPrice = (v?: number) => {
        // TODO не присылает ивент, если стёрли значение
        onTicketChange(ticket.withPrice(v));
    }
    
    return (
        <Gapped vertical={true} gap={10}>
            <Label label={`Билет ${ticketNum}`} size={'medium'} />
            <SingleStringQuestion title={'Название'} onValueChange={onChangeTicketName} size={'small'} defaultValue={ticket.Name} />
            <Label label={'Стоимость'} size={'small'} />
            <CurrencyInput fractionDigits={0} onValueChange={onChangeTicketPrice} size={'small'} value={ticket.Price} />
        </Gapped>
    );
};