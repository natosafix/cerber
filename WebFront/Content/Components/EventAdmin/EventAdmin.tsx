import * as React from 'react';
import { useState } from 'react';
import styles from './EventAdmin.scss';
import { EventStepsNav } from './EventStepsNav/EventStepsNav';
import { EventCoverSheet } from './EventCoverSheet/EventCoverSheet';
import { EventAdminPageNav } from './EventStepsNav/EventAdminPageNav';
import { EventQuizCreator } from './EventQuizCreator/EventQuizCreator';
import { EventTickets } from './EventTickets/EventTickets';
import { Gapped } from '@skbkontur/react-ui';
import { EventAdminClient } from '../../../Api/EventAdmin/EventAdminClient';
import { TicketDto } from '../../../Api/Models/TicketDto';
import { Ticket } from '../../Entries/Shared/TicketView/Ticket';
import { EventPublish } from './EventPublish/EventPublish';


export const EventAdmin: React.FC = () => {
    const [step, setStep] = useState(EventAdminPageNav.EventCoverSheet);

    const onSave: () => Promise<void> = async () => {
        if (step === EventAdminPageNav.EventPublish) {
            EventAdminClient.publishDraft()
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
                        {step === EventAdminPageNav.EventTickets && (
                            <EventTickets onSave={onSave} />
                        )}
                        {step === EventAdminPageNav.EventPublish && (
                            <EventPublish onSave={onSave} />
                        )}
                    </Gapped>
                </div>
            </div>
        </div>);
};