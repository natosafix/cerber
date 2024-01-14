import axios from 'axios';
import { QuestionDto } from './QuestionDto';

const quizApi = axios.create({baseURL: '/Quiz'});
const questionsApi = axios.create({baseURL: '/Questions'})

export class QuizSolveClient {
    public static getQuestions(eventId: number) {
        return questionsApi.get<QuestionDto[]>('/', {params: {eventId: eventId}});
    }
}