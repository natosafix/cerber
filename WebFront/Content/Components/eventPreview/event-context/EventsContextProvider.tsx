import { createContext, useContext, FC, useState } from 'react';
import React from 'react'
import { IEvent } from '../models';
import * as events from "events";

export interface IEventsContext {
  events: IEvent[];
  setEvents(events: IEvent[]): void;
}

interface EventsProviderProps {
}


const EventsContext = createContext<IEventsContext | undefined>(undefined);
const useEventsContext = (): IEventsContext => {
  return useContext(EventsContext) as IEventsContext;
};

const EventsProvider: FC<EventsProviderProps> = (props ) => {
  const [events, setEvents] = useState<IEvent[]>([]);

  const EventContextValue: IEventsContext = {
    events: events,
    setEvents: setEvents
  };

  return <EventsContext.Provider value={EventContextValue} {...props} />;
};



export { EventsProvider, useEventsContext }