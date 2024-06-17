import axios, { AxiosResponse } from 'axios';
import { IEvent } from '../Models/IEvent';
import { Route } from '../../../Utility/Constants';

let shouldSendNextRequest = true;

export const getEvents = async (count: number): Promise<IEvent[] | null> => {
    try {
        if (!shouldSendNextRequest) {
            return null;
        }

        const response = await axios.get<IEvent[]>(Route.GET_EVENTS(count));

        const eventsCount = response.data.length;

        if (eventsCount < 6) {
            shouldSendNextRequest = false;
        }

        return await Promise.all(
            response.data.map(async (event: IEvent) => {
                return await fetchEventCover(event);
            }),
        );
    } catch (error) {
        throw error;
    }
};

export const createDraft = async () => {
    try {
        await axios.post(`/createDraft`);
    } catch (error) {}
};

export const getDraft = async (): Promise<AxiosResponse<IEvent> | undefined> => {
    try {
        return await axios.get<IEvent>(Route.GET_DRAFT);
    } catch (error) {
        return undefined;
    }
};

export const register = async (userData) => {
    try {
        const response = await axios.post(Route.API_REGISTER, userData);
        return {
            success: true,
            data: response.data,
            message: 'Registration successful',
        };
    } catch (error) {
        return {
            success: false,
            data: error.response.data,
            message: 'Registration failed',
        };
    }
};

export const login = async ({ email, password }) => {
    try {
        const response = await axios.post(Route.API_LOGIN, { email, password });
        localStorage.setItem('token', response.data.token);
        return {
            success: true,
            data: response.data,
            message: 'Login successful',
        };
    } catch (error) {
        return {
            success: false,
            data: error.response.data,
            message: 'Login failed',
        };
    }
};

export const getEvent = async (id?: string): Promise<IEvent> => {
    try {
        if (id === undefined) {
            throw new Error('Event ID is undefined.');
        }
        const response = await axios.get<IEvent>(Route.GET_EVENT(id));
        return await fetchEventCover(response.data);
    } catch (error) {
        throw error;
    }
};

async function fetchEventCover(event: IEvent): Promise<IEvent> {
    try {
        const coverResponse: AxiosResponse<ArrayBuffer> = await axios.get(Route.FETCH_EVENT_COVER(event), {
            responseType: 'arraybuffer',
        });
        const blob = new Blob([coverResponse.data], { type: 'image/*' });
        return { ...event, img: blob };
    } catch (error) {
        return event;
    }
}

export const findUsers = async (username: string) => {
    try {
        const response = await axios.get<string[]>(Route.FIND_USERS(username));
        return response.data;
    } catch (error) {}
};

export const addInspector = async (event: IEvent, username: string) => {
    try {
        const response = await axios.put(Route.ADD_INSPECTORS(event), { username: username });
        return response.data;
    } catch (error) {}
};

export const deleteInspector = async (event: IEvent, username: string) => {
    try {
        const response = await axios.delete(Route.DELETE_INSPECTORS(event, username));
        return response.data;
    } catch (error) {}
};

export const getInspectors = async (event: IEvent) => {
    try {
        const response = await axios.get<string[]>(Route.GET_INSPECTORS(event.id));
        return response.data;
    } catch (error) {}
};
