﻿import React, { useEffect, useRef, useState } from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';
import { Ticket } from './Ticket';
import { TicketView } from './TicketView';
import { Button, Gapped } from '@skbkontur/react-ui';
import { BinButton } from '../../../Entries/Shared/BinButton/BinButton';
import binBtnStyles from '../../../Entries/Shared/BinButton/BinButton.scss';
import { ValidationContainer, ValidationWrapper } from '@skbkontur/react-ui-validations';
import { DraftQuestionDto } from '../../../../Api/EventAdmin/DraftQuestionDto';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';

interface Props {
    onSave: () => void;
    onTicketsChange: (tickets: Ticket[]) => void;
}

function ticketExistsValidate(tickets: Ticket[]): Nullable<ValidationInfo> {
    if (!tickets || tickets.length === 0) {
        return { message: 'Необходимо добавить хотя бы один билет', type: 'submit' };
    }

    return null;
}

export const EventPublish: React.FC<Props> = ({ onSave, onTicketsChange }) => {
    const [tickets, setTickets] = useState<Ticket[]>([]);
    const [ticketsCount, setTicketsCount] = useState(0);
    const validWrapper = useRef<ValidationContainer>(null);

    useEffect(() => {
        onTicketsChange(tickets);
    }, [tickets]);

    const onAddTicketBtn = () => {
        setTickets([...tickets, new Ticket(ticketsCount)]);
        setTicketsCount(ticketsCount + 1);
    };

    const onChangeTicket = (ticket: Ticket) => {
        const matchIdx = tickets.findIndex((t) => t.ViewId === ticket.ViewId);

        tickets[matchIdx] = ticket;
        setTickets(tickets);
    };

    const onRemoveTicket = (viewId: number) => {
        setTickets(tickets.filter(t => t.ViewId !== viewId));
    };

    const onSaveBtnClick = async () => {
        if (validWrapper.current) {
            const isValid = await validWrapper.current.validate();
            if (isValid) {
                onSave();
            }
        }
    };

    return (
        <ValidationContainer ref={validWrapper}>
            <Gapped vertical gap={20}>
                {tickets.map((ticket, id) => (
                    <div key={ticket.ViewId} className={binBtnStyles.relativeWrapper}>
                        <div className={binBtnStyles.binBtnWrapper}>
                            <BinButton onClick={() => onRemoveTicket(ticket.ViewId)} />
                        </div>
                        <TicketView ticket={ticket} ticketNum={id + 1} onTicketChange={onChangeTicket} />
                    </div>
                ))}

                <ValidationWrapper validationInfo={ticketExistsValidate(tickets)}>
                    <Button onClick={onAddTicketBtn}>
                        Добавить билет
                    </Button>
                </ValidationWrapper>

                <EventAdminSaveBtn onSave={onSaveBtnClick} title={'Опубликовать'} />
            </Gapped>
        </ValidationContainer>
    );
};