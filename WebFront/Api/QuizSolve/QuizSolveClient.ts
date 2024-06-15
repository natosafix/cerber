import axios from 'axios';
import { QuestionDto } from './QuestionDto';
import { TicketDto } from '../Models/TicketDto';
import { CreateOrderDto } from './CreateOrderDto';
import { Route } from '../../Content/Utility/Constants';

const api = axios.create();

export class QuizSolveClient {
    public static getQuestions(eventId: number) {
        return api.get<QuestionDto[]>(Route.GET_QUESTIONS_TO_SOLVE, { params: { eventId: eventId } });
    }

    public static getTickets(eventId: number) {
        return api.get<TicketDto[]>(Route.GET_TICKETS, { params: { eventId: eventId } });
    }

    public static createOrder(createOrderDto: CreateOrderDto): Promise<string> {
        return api.post<string>(Route.CREATE_ORDER, createOrderDto).then((r) => r.data);
    }

    public static getCongratsUrl(eventId: number): string {
        return api.getUri({ url: Route.GET_CONGRATS, params: { eventId: eventId } });
    }

    public static getRetryPaymentUrl(customer: string): Promise<string> {
        return api.get<string>(Route.RETRY_PAYMENT(customer)).then((url) => url.data);
    }

    public static getEventDetailsUrl(eventId: number): string {
        return api.getUri({ url: Route.GET_EVENT_DETAILS(eventId) });
    }
}
