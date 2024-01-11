import * as React from 'react';
import { useEffect } from 'react';
import Events from './Events';
import { useEvents } from './event-context';
import styles from './eventPreview.scss'


export const EventPreview: React.FC = () => {
    const { events, fetchEvents } = useEvents();

    useEffect(() => {
        fetchEvents();
    }, [fetchEvents]);

    return (
        <div>
            <Events events={events} />
        </div>
    );
}
