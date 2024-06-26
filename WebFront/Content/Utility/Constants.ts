import { IEvent } from '../Components/EventPreview/Models/IEvent';
import { SxProps } from '@mui/system';
import { Theme } from '@mui/material/styles';

export const Route = {
    INDEX: '/home/index',
    LOGIN: '/home/login',
    MY_EVENTS: '/home/myEvents',
    REGISTER: '/home/register',
    DRAFT: '/eventAdmin/draft',
    PREVIEW: (id: number) => `/home/preview/${id}`,
    GET_DRAFT: '/EventAdmin/draftCover',
    SET_DRAFT: '/EventAdmin/draftCover',
    GET_QUESTIONS: '/EventAdmin/questions',
    SET_QUESTIONS: '/EventAdmin/questions',
    GET_COVER_IMAGE: '/EventAdmin/coverImage',
    SET_COVER_IMAGE: '/EventAdmin/coverImage',
    GET_DRAFT_TICKETS: '/EventAdmin/tickets',
    GET_TICKET_IMAGE: (ticketId: number) => `/EventAdmin/ticketImage/${ticketId}`,
    SET_DRAFT_TICKETS: '/EventAdmin/tickets',
    REMOVE_COVER_IMAGE: '/EventAdmin/coverImage',
    PUBLISH_DRAFT: '/EventAdmin/publishDraft',
    CREATE_DRAFT: '/EventAdmin/createDraft',
    GET_TICKETS: '/Tickets',
    GET_EVENT_DETAILS: (eventId: Number) => `/Home/preview/${eventId}`,
    GET_CONGRATS: '/Quiz/congrats',
    RETRY_PAYMENT: (customer: string) => `/orders/${customer}/retryPayment`,
    GET_QUESTIONS_TO_SOLVE: '/Questions',
    CREATE_ORDER: '/Orders',
    GET_OWNED_EVENTS: (count: Number) => `/events/owned?offset=${count}&limit=6`,
    GET_INCOMING_EVENTS: (count: Number) => `/events/incoming?offset=${count}&limit=6`,
    GET_INSPECTORS: (eventId: Number) => `/events/${eventId}/inspectors`,
    GET_STATS: (eventId: Number) => `/events/${eventId}/stats`,
    DELETE_INSPECTORS: (event: IEvent, username: string) => `/events/${event.id}/inspector?username=${username}`,
    ADD_INSPECTORS: (event: IEvent) => `/events/${event.id}/inspectorByUsername`,
    FIND_USERS: (username: string) => `/users?username=${username}`,
    FETCH_EVENT_COVER: (event: IEvent) => `/events/${event.id}/cover`,
    GET_EVENT: (id: string) => `/events/${id}`,
    API_LOGIN: '/Auth/login',
    API_REGISTER: '/Auth/register',
    QUIZ: (id?: string) => `/quiz/solve/${id}`,
};

export type Size = 'small' | 'medium' | 'large';
export type ButtonColor = 'black' | 'green';

export const ValidationMessages = {
    FieldRequired: 'Поле обязательно для заполнения',
    InvalidValue: 'Невалидное значение',
    OneHundredCharactersLimit: 'Не более 100 символов',
};

export const GetLoadingButtonStyle = (color: ButtonColor): SxProps<Theme> => {
    let btnColor = 'white';
    if (color === 'green') {
        btnColor = '#78BF2B';
    } else if (color === 'black') {
        btnColor = '#3D3D3D';
    }

    return {
        backgroundColor: btnColor,
        borderColor: btnColor,
        '&:hover': {
            opacity: 0.9,
            borderColor: btnColor,
            backgroundColor: btnColor,
        },
    };
};