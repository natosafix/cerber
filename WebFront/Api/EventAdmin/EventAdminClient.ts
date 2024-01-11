﻿import axios from 'axios';
import {DraftEvent, DraftEventDto} from "./DraftEvent";
import {DraftQuestionDto} from "./DraftQuestionDto";
import {FileUploaderAttachedFile} from "@skbkontur/react-ui";

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

    public static getCoverImage() {
        return api.get('/coverImage');
    }

    public static setCoverImage(file: FileUploaderAttachedFile): Promise<void> {
        let formData = new FormData();
        formData.append('file', file.originalFile, file.originalFile.name);
        return api.post('/coverImage', formData, {
            headers: {
                "Content-Type": `multipart/form-data`,
            }
        });
    }

    public static createDraft() {
        return api.post<DraftEvent | null>('/createDraft');
    }
}