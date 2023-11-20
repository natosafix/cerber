import { useCallback } from 'react';


import { useEventsContext } from './EventsContextProvider';
import { IEvent } from '../models';
import { getEvents } from '../services/events';

const useEvents = () => {
  const {
    events,
    setEvents,
  } = useEventsContext();
  
  const fetchEvents = useCallback(() => {
    getEvents().then((events: IEvent[]) => {
      setEvents(events);
    });
  }, [setEvents]);

  return {
    fetchEvents: fetchEvents,
    events: events
  };
};

export default useEvents;