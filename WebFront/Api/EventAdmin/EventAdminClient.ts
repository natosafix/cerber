import axios from 'axios';
import { DraftEvent, DraftEventDto } from './DraftEvent';
import { FileUploaderAttachedFile } from '@skbkontur/react-ui';
import { DraftQuestionDto } from './DraftQuestionDto';

const api = axios.create({ baseURL: '/EventAdmin' });

export class EventAdminClient {
    public static getDraftCover() {
        return api.get<DraftEventDto>('/draftCover');
    }

    public static setDraftCover(draft: DraftEvent) {
        return api.post('/draftCover', draft);
    }

    public static getQuestions() {
        return api.get<DraftQuestionDto[]>('/questions');
    }

    public static setQuestions(questions: DraftQuestionDto[]) {
        return api.post('/questions', questions);
    }

    public static getCoverImage() {
        return api.get('/coverImage');
    }

    public static getCoverImageUrl(): string {
        return api.getUri({ url: '/coverImage' });
    }

    public static setCoverImage(file: FileUploaderAttachedFile): Promise<void> {
        let formData = new FormData();
        formData.append('file', file.originalFile, file.originalFile.name);
        return api.post('/coverImage', formData, {
            headers: {
                'Content-Type': `multipart/form-data`,
            },
        });
    }

    public static removeCoverImage() {
        return api.delete('/coverImage');
    }

    public static publishDraft() {
        return api.post('/publishDraft');
    }

    public static createDraft() {
        return api.post<DraftEvent | null>('/createDraft');
    }
}