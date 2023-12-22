import axios from 'axios';
import {DraftEvent} from "./DraftEvent";

const api = axios.create({baseURL: '/EventAdmin'});

export class EventAdminClient {
    public static getDraftCover(id: string) {
        return api.get<DraftEvent | null>('/draftCover', {params: {id: id}});
    }

    public static setDraftCover(id: string, draft: DraftEvent) {
        return api.post('/draftCover', draft, {params: {id: id}})
    }

    public static createDraft() {
        return api.post<DraftEvent | null>('/createDraft');
    }
}