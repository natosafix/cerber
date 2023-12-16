import axios from 'axios';

const api = axios.create({ baseURL: '/Events' });

export class EventAdminClient {
    public static createDraft() {
        return api.post<void>('/createDraft');
    }
}