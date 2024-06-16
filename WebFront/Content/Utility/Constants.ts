import { IEvent } from '../Components/EventPreview/Models/IEvent';

export const Route = {
    INDEX: '/home/index',
    LOGIN: '/home/login',
    REGISTER: '/home/register',
    DRAFT: '/eventAdmin/draft',
    PREVIEW: (id: number) => `/home/preview/${id}`,
    GET_DRAFT: '/EventAdmin/draftCover',
    SET_DRAFT: '/EventAdmin/draftCover',
    GET_QUESTIONS: '/EventAdmin/questions',
    SET_QUESTIONS: '/EventAdmin/questions',
    GET_COVER_IMAGE: '/EventAdmin/coverImage',
    SET_COVER_IMAGE: '/EventAdmin/coverImage',
    SET_TICKETS: '/EventAdmin/tickets',
    REMOVE_COVER_IMAGE: '/EventAdmin/coverImage',
    PUBLISH_DRAFT: '/EventAdmin/publishDraft',
    CREATE_DRAFT: '/EventAdmin/createDraft',
    GET_TICKETS: '/Tickets',
    GET_EVENT_DETAILS: (eventId: Number) => `/Home/preview/${eventId}`,
    GET_CONGRATS: '/Quiz/congrats',
    RETRY_PAYMENT: (customer: string) => `/orders/${customer}/retryPayment`,
    GET_QUESTIONS_TO_SOLVE: '/Questions',
    CREATE_ORDER: '/Orders',
    GET_EVENTS: (count: Number) => `/events/owned?offset=${count}&limit=6`,
    GET_INSPECTORS: (event: IEvent) => `/events/${event.id}/inspectors`,
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

export const ValidationMessages = {
    FieldRequired: 'Поле обязательно для заполнения',
    InvalidValue: 'Невалидное значение',
    OneHundredCharactersLimit: 'Не более 100 символов',
};
