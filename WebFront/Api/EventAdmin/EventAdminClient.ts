import axios from 'axios';
import {DraftEvent} from "./DraftEvent";

const api = axios.create({baseURL: '/Events'});

export class EventAdminClient {
    public static getDraft() {
        return api.get<DraftEvent | null>('/draft');
    }

    public static createDraft() {
        return api.post<DraftEvent | null>('/createDraft');
    }
}