import * as React from 'react';
import { useEffect } from 'react';
import Events from './Events';
import { useEvents } from './event-context';


export const EventPreview: React.FC = () => {
    const { events, fetchEvents } = useEvents();

    useEffect(() => {
        fetchEvents();
    }, [fetchEvents]);

    return (
        <div>
            <p>Мероприятий найдено: {events?.length}</p>
            <Events events={events} />
        </div>
    );
}
