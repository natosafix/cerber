import React, { useEffect, useState } from 'react';
import styles from './EventDetails.scss';
import { ButtonInfo, EventStepsNav } from '../../EventAdmin/EventStepsNav/EventStepsNav';
import { EventDetailsPageNav } from './EventDetailsPageNav';
import { Gapped } from '@skbkontur/react-ui';
import { EventPreviewDetails } from './EventPreviewDetails/EventPreviewDetails';
import { EventStats } from '../../EventStats/EventStats';
import { IEvent } from '../Models/IEvent';
import { getEvent } from '../Services/Events';
import { EventsClient } from '../../../../Api/Events/EventsClient';
import { IEventStats } from '../../../../Api/Events/IEventStats';

export const EventDetails: React.FC<{ id?: string }> = ({ id }) => {
    const [step, setStep] = useState(EventDetailsPageNav.EventDetails);
    const [event, setEvent] = useState<IEventStats | null>(null);

    const buttonsInfo = [
        new ButtonInfo('Обзор', EventDetailsPageNav.EventDetails, false),
        new ButtonInfo('Статистика', EventDetailsPageNav.EventStats, event === null || event.ticketsStats.length === 0),
    ];

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            try {
                if (id) {
                    await EventsClient.getEventStats(parseInt(id)).then((x) => setEvent(x.data));
                }
            } catch (error) {}
        };

        fetchEventDetailsAndCover();
    }, [id]);

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            console.log(event);
        };

        fetchEventDetailsAndCover();
    }, [event]);

    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav<EventDetailsPageNav> buttons={buttonsInfo} step={step} setStepNav={setStep} />

            <div className={styles.contentPageWrapper}>
                <div className={styles.contentWrapper}>
                    <Gapped gap={30} vertical={true}>
                        {step === EventDetailsPageNav.EventDetails && <EventPreviewDetails id={id} />}
                        {step === EventDetailsPageNav.EventStats && event !== null && event.ticketsStats.length > 0 && (
                            <EventStats eventStats={event} />
                        )}
                    </Gapped>
                </div>
            </div>
        </div>
    );
};
