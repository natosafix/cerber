
import React, { useEffect } from 'react';
import Events from './Events';
import { useEvents } from './event-context';
import styles from './eventPreview.scss';

export const EventPreview = () => {
    const { events, fetchEvents } = useEvents();

    useEffect(() => {
        fetchEvents();
    }, [fetchEvents]);

    return (
        <div className={styles.eventPreview}>
            <Events events={events} />
        </div>
    );
};
