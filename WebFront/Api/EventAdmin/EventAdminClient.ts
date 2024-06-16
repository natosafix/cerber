import axios from 'axios';
import { DraftEvent, DraftEventDto } from './DraftEvent';
import { FileUploaderAttachedFile } from '@skbkontur/react-ui';
import { DraftQuestionDto } from './DraftQuestionDto';
import { TicketDto } from '../Models/TicketDto';
import { Route } from '../../Content/Utility/Constants';
import { Form } from 'react-router-dom';
import { DraftTicketDto } from '../Models/DraftTicketDto';

const api = axios.create();

export class EventAdminClient {
    public static getDraftCover() {
        return api.get<DraftEventDto>(Route.GET_DRAFT);
    }

    public static setDraftCover(draft: DraftEvent) {
        return api.post(Route.SET_DRAFT, draft);
    }

    public static getQuestions() {
        return api.get<DraftQuestionDto[]>(Route.GET_QUESTIONS);
    }

    public static setQuestions(questions: DraftQuestionDto[]) {
        return api.post(Route.SET_QUESTIONS, questions);
    }

    public static getCoverImage() {
        return api.get(Route.GET_COVER_IMAGE);
    }

    public static getCoverImageUrl(): string {
        const uri = api.getUri({ url: Route.GET_COVER_IMAGE });
        console.log(uri);
        return uri;
    }

    public static setCoverImage(file: FileUploaderAttachedFile): Promise<void> {
        let formData = new FormData();
        formData.append('file', file.originalFile, file.originalFile.name);
        return api.post(Route.SET_COVER_IMAGE, formData, {
            headers: {
                'Content-Type': `multipart/form-data`,
            },
        });
    }

    public static getTickets() {
        return api.get<DraftTicketDto[]>(Route.GET_DRAFT_TICKETS);
    }

    public static async getTicketImage(ticketId: number): Promise<Blob> {
        return await api
            .get<Blob>(Route.GET_TICKET_IMAGE(ticketId), {
                responseType: 'blob',
            })
            .then((x) => x.data);
    }

    public static setTickets(tickets: DraftTicketDto[]) {
        let formData = new FormData();

        tickets.map((ticket, i) => {
            formData.append(`tickets[${i}].name`, ticket.name);
            formData.append(`tickets[${i}].price`, ticket.price!.toString());
            formData.append(`tickets[${i}].coverImage`, ticket.cover!, `tickets[${i}].coverImage`);
            return formData;
        });

        return api.post(Route.SET_DRAFT_TICKETS, formData, {
            headers: {
                'Content-Type': `multipart/form-data`,
            },
        });
    }

    public static removeCoverImage() {
        return api.delete(Route.REMOVE_COVER_IMAGE);
    }

    public static publishDraft() {
        return api.post(Route.PUBLISH_DRAFT);
    }

    public static createDraft() {
        return api.post<DraftEvent | null>(Route.CREATE_DRAFT);
    }
}
