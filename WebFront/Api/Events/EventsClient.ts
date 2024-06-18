import axios from 'axios';
import { Route } from '../../Content/Utility/Constants';
import { IEventStats } from './IEventStats';
import { IEvent } from '../../Content/Components/EventPreview/Models/IEvent';

const api = axios.create();

export class EventsClient {
    public static async getEventStats(eventId: Number) {
        return await api.get<IEventStats>(Route.GET_STATS(eventId));
    }

    public static async getIncomingEvents(count: Number) {
        return await api.get<IEvent[]>(Route.GET_INCOMING_EVENTS(count)); //TODO: логика со скипом ивентов
    }
}
