import { useCallback } from 'react';
import { useEventsContext } from './EventsContextProvider';
import { getEvents } from '../Services/Events';

export const useEvents = () => {
    const { events, setEvents } = useEventsContext();

    const fetchEvents = useCallback(
        async (page) => {
            try {
                const newEvents = await getEvents(page);
                if (newEvents) {
                    setEvents((prevEvents) => [...prevEvents, ...newEvents]);
                } else {
                    setEvents((prevEvents) => [...prevEvents]);
                }
            } catch (error) {}
        },
        [setEvents],
    );

    return {
        fetchEvents,
        events,
    };
};
