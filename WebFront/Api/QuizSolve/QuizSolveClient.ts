import axios from 'axios';
import { QuestionDto } from './QuestionDto';
import { TicketDto } from '../Models/TicketDto';
import { CreateOrderDto } from './CreateOrderDto';

const quizApi = axios.create({ baseURL: '/Quiz' });
const questionsApi = axios.create({ baseURL: '/Questions' });
const ticketsApi = axios.create({ baseURL: '/Tickets' });
const ordersApi = axios.create({ baseURL: '/Orders' });
const homeApi = axios.create({ baseURL: '/Home' });

export class QuizSolveClient {
    public static getQuestions(eventId: number) {
        return questionsApi.get<QuestionDto[]>('', { params: { eventId: eventId } });
    }

    public static getTickets(eventId: number) {
        return ticketsApi.get<TicketDto[]>('', { params: { eventId: eventId } });
    }

    public static createOrder(createOrderDto: CreateOrderDto) {
        return ordersApi.post('/', createOrderDto);
    }

    public static getCongratsUrl(eventId: number): string {
        return quizApi.getUri({ url: '/congrats', params: { eventId: eventId } });
    }

    public static getEventDetailsUrl(eventId: number): string {
        return homeApi.getUri({ url: `/preview/${eventId}` });
    }
}