import axios from 'axios';
import { Route } from '../../Content/Utility/Constants';
import { IEventStats } from './IEventStats';

const api = axios.create();

export class EventsClient {
    public static getEventStats(eventId: Number) {
        return api.get<IEventStats>(Route.GET_STATS(eventId));
    }
}