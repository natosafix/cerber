import styles from './EventAdmin.scss';
import * as React from 'react';
import { useState } from 'react';
import { Gapped } from '@skbkontur/react-ui';
import { EventAdminClient } from '../../../Api/EventAdmin/EventAdminClient';
import { EventAdminPageNav } from './EventStepsNav/EventAdminPageNav';
import { EventCoverSheet } from './EventCoverSheet/EventCoverSheet';
import { EventPublish } from './EventPublish/EventPublish';
import { EventQuizCreator } from './EventQuizCreator/EventQuizCreator';
import { ButtonInfo, EventStepsNav } from './EventStepsNav/EventStepsNav';
import { EventTickets } from './EventTickets/EventTickets';

export const EventAdmin: React.FC = () => {
    const [step, setStep] = useState(EventAdminPageNav.EventCoverSheet);
    const buttonsInfo = [
        new ButtonInfo('Описание события', EventAdminPageNav.EventCoverSheet),
        new ButtonInfo('Анкета регистрации', EventAdminPageNav.EventQuizCreator),
        new ButtonInfo('Билеты', EventAdminPageNav.EventTickets),
        new ButtonInfo('Публикация', EventAdminPageNav.EventPublish),
    ];
    const onSave: () => Promise<void> = async () => {
        if (step === EventAdminPageNav.EventPublish) {
            EventAdminClient.publishDraft().then((r) => (window.location.href = r.data));
        } else {
            setStep(step + 1);
        }
    };

    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav<EventAdminPageNav> buttons={buttonsInfo} step={step} setStepNav={setStep} />

            <div className={styles.contentPageWrapper}>
                <div className={styles.contentWrapper}>
                    <Gapped gap={30} vertical={true}>
                        {step === EventAdminPageNav.EventCoverSheet && <EventCoverSheet onSave={onSave} />}
                        {step === EventAdminPageNav.EventQuizCreator && <EventQuizCreator onSave={onSave} />}
                        {step === EventAdminPageNav.EventTickets && <EventTickets onSave={onSave} />}
                        {step === EventAdminPageNav.EventPublish && <EventPublish onSave={onSave} />}
                    </Gapped>
                </div>
            </div>
        </div>
    );
};
