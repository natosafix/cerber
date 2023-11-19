import axios from 'axios';

const api = axios.create({ baseURL: '/Events' });

export class EventsClient {    
    public static async getEvents() {
        return api.get<any>('');
    }

    public static async getEvent(eventId: string) {
        try {
            // const response = await axios.get(`/${eventId}`);
        } catch (error) {
            console.error(error);
        }
        
    }
}
