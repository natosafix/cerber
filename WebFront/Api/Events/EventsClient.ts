import axios from 'axios';
import { Route } from '../../Content/Utility/Constants';
import { IEventStats } from './IEventStats';

const api = axios.create();

export class EventsClient {
    public static async getEventStats(eventId: Number) {
        return await api.get<IEventStats>(Route.GET_STATS(eventId));
    }
}
