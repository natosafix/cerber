import axios from 'axios';
import {DraftEvent, DraftEventDto} from "./DraftEvent";
import {DraftQuestionDto} from "./DraftQuestionDto";

const api = axios.create({baseURL: '/EventAdmin'});

export class EventAdminClient {
    public static getDraftCover() {
        return api.get<DraftEventDto>('/draftCover');
    }

    public static setDraftCover(draft: DraftEvent) {
        return api.post('/draftCover', draft)
    }

    public static getQuestions() {
        return api.get<DraftQuestionDto[]>('/questions');
    }

    public static setQuestions(questions: DraftQuestionDto[]) {
        return api.post('/questions', questions);
    }

    public static createDraft() {
        return api.post<DraftEvent | null>('/createDraft');
    }
}