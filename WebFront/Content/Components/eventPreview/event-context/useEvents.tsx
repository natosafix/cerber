import { useCallback } from 'react';
import { useEventsContext } from './EventsContextProvider';
import { getEvents } from '../services/events';

const useEvents = () => {
  const {
    events,
    setEvents,
  } = useEventsContext();

  const fetchEvents = useCallback(async (page) => {
    try {
      const newEvents = await getEvents(page);

      setEvents((prevEvents) => [...prevEvents, ...newEvents]);
    } catch (error) {
      console.error('Error fetching events:', error);
    }
  }, [setEvents]);

  return {
    fetchEvents,
    events,
  };
};

export default useEvents;
