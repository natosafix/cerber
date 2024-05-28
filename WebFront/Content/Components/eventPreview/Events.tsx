import React, { useState } from 'react';
import styles from './Events.scss';
import Event from './event/Event';
import { IEvent } from './Models/IEvent';
import { CardSkeleton } from './event/EventSkeleton/EventSkeleton';

interface IEventsProps {
    events: IEvent[];
    loading: boolean;
}
export const Events: React.FC<IEventsProps> = ({ events, loading }) => {
    return (
        <div className={styles.eventsWrapper}>
            <div className={styles.events}>
                {events?.map((event) => <Event event={event} key={event.id} />)}
                {loading && <CardSkeleton cards={6} />}
            </div>
        </div>
    );
};
