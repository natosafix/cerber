import { createContext, useContext, FC, useState } from 'react';
import React from 'react';
import { IEvent } from '../Models/IEvent';

export interface IEventsContext {
    events: IEvent[];
    setEvents: React.Dispatch<React.SetStateAction<IEvent[]>>;
}

interface EventsProviderProps {}

const EventsContext = createContext<IEventsContext | undefined>({
    events: [],
    setEvents: () => {},
});

const useEventsContext = (): IEventsContext => {
    const context = useContext(EventsContext);
    if (!context) {
        throw new Error('useEventsContext must be used within an EventsProvider');
    }
    return context;
};

const EventsProvider: FC<EventsProviderProps> = (props) => {
    const [events, setEvents] = useState<IEvent[]>([]);
    const EventContextValue: IEventsContext = {
        events: events,
        setEvents: setEvents,
    };

    return <EventsContext.Provider value={EventContextValue} {...props} />;
};

export { EventsProvider, useEventsContext };
