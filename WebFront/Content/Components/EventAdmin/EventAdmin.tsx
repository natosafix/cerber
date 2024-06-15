import * as React from 'react';
import { useState } from 'react';
import styles from './EventAdmin.scss';
import { EventStepsNav } from './EventStepsNav/EventStepsNav';
import { EventCoverSheet } from './EventCoverSheet/EventCoverSheet';
import { EventAdminPageNav } from './EventStepsNav/EventAdminPageNav';
import { EventQuizCreator } from './EventQuizCreator/EventQuizCreator';
import { EventPublish } from './EventPublish/EventPublish';
import { Gapped } from '@skbkontur/react-ui';
import { EventAdminClient } from '../../../Api/EventAdmin/EventAdminClient';
import { TicketDto } from '../../../Api/Models/TicketDto';
import { Ticket } from '../../Entries/Shared/TicketView/Ticket';


export const EventAdmin: React.FC = () => {
    const [step, setStep] = useState(EventAdminPageNav.EventCoverSheet);
    const [tickets, setTickets] = useState<Ticket[]>([]);

    const onSave = async () => {
        if (step === EventAdminPageNav.EventPublish) {
            EventAdminClient.publishDraft(tickets.map(ticket => new TicketDto(ticket.Name, ticket.Price ?? 0)))
                .then(r => window.location.href = r.data);
        } else {
            setStep(step + 1);
        }
    };

    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav step={step} setStepNav={setStep} />

            <div className={styles.contentPageWrapper}>
                <div className={styles.contentWrapper}>
                    <Gapped gap={30} vertical={true}>
                        {step === EventAdminPageNav.EventCoverSheet && (
                            <EventCoverSheet onSave={onSave} />
                        )}
                        {step === EventAdminPageNav.EventQuizCreator && (
                            <EventQuizCreator onSave={onSave} />
                        )}
                        {step === EventAdminPageNav.EventPublish && (
                            <EventPublish onSave={onSave} onTicketsChange={setTickets} />
                        )}
                    </Gapped>
                </div>
            </div>
        </div>);
};