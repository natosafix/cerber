import { useCallback } from 'react';
import { useEventsContext } from './EventsContextProvider';
import { getEvents, getIncomingEvents } from '../Services/Events';

export const useEvents = (isPrivate) => {
    const { events, setEvents, haveMore, setHaveMore } = useEventsContext();
    const fetchEvents = useCallback(
        async (page) => {
            try {
                const newEvents = isPrivate ? await getEvents(page) : await getIncomingEvents(page);
                if (newEvents) {
                    setEvents((prevEvents) => [...prevEvents, ...newEvents]);
                } else {
                    setEvents((prevEvents) => [...prevEvents]);
                }
                setHaveMore(newEvents !== null && newEvents.length === 6);
            } catch (error) {}
        },
        [setEvents],
    );
    return {
        fetchEvents,
        events,
        haveMore,
    };
};
