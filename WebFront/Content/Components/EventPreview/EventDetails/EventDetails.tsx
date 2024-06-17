import React, { useEffect, useRef, useState } from 'react';
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
import { getUserInfo } from '../../../Helpers/UserInfoHelper';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';
import { DraftEvent } from '../../../../Api/EventAdmin/DraftEvent';

export const EventDetails: React.FC<{ id?: string }> = ({ id }) => {
    const [step, setStep] = useState(EventDetailsPageNav.EventDetails);
    const [event, setEvent] = useState<IEvent | null>(null);
    const [eventStats, setEventStats] = useState<IEventStats | null>(null);

    const [userId, setUserId] = useState<string>();
    const buttonsInfoFull = [
        new ButtonInfo('Обзор', EventDetailsPageNav.EventDetails, false),
        new ButtonInfo(
            'Статистика',
            EventDetailsPageNav.EventStats,
            eventStats === null || eventStats.ticketsStats.length === 0,
        ),
    ];

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            try {
                if (id) {
                    await EventsClient.getEventStats(parseInt(id)).then((x) => setEventStats(x.data));
                }
            } catch (error) {}
        };

        fetchEventDetailsAndCover();
    }, [id]);

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            const userInfo = getUserInfo();
            if (userInfo) {
                setUserId(userInfo.id);
            }
        };

        fetchEventDetailsAndCover();
    }, [event]);

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            try {
                if (id) {
                    await getEvent(id).then((x) => setEvent(x));
                } else {
                    EventAdminClient.getDraftCover().then(async (x) => {
                        const event = await DraftEvent.fromDto(x.data).toIEvent();
                        setEvent(event);
                    });
                }
            } catch (error) {}
        };

        fetchEventDetailsAndCover();
    }, [id]);

    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav<EventDetailsPageNav>
                off={!(event !== null && userId === event?.ownerId)}
                buttons={buttonsInfoFull}
                step={step}
                setStepNav={setStep}
            />

            <div className={styles.contentPageWrapper}>
                <div className={styles.contentWrapper}>
                    <Gapped gap={30} vertical={true}>
                        {step === EventDetailsPageNav.EventDetails && event !== null && (
                            <EventPreviewDetails userId={userId} event={event} />
                        )}
                        {step === EventDetailsPageNav.EventStats &&
                            eventStats !== null &&
                            eventStats.ticketsStats.length > 0 && <EventStats eventStats={eventStats} />}
                    </Gapped>
                </div>
            </div>
        </div>
    );
};
