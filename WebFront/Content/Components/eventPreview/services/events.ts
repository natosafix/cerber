import axios, { AxiosResponse } from 'axios';
import { IEvent } from '../models';

let shouldSendNextRequest = true;

export const getEvents = async (count: number): Promise<IEvent[]> => {
  try {
    if (!shouldSendNextRequest) {
      return [];
    }

    console.log(count);
    const response = await axios.get<IEvent[]>(`/events/owned?offset=${count}&limit=6`);

    const eventsCount = response.data.length;

    if (eventsCount < 6) {
      shouldSendNextRequest = false;
    }

    const eventsWithImages = await Promise.all(response.data.map(async (event) => {
      return await fetchEventCover(event);
    }));

    return eventsWithImages;
  } catch (error) {
    throw error;
  }
};


export const createDraft = async () => {
  try {
    await axios.post<IEvent>(`/createDraft`);
  } catch (error) {
    console.error(error);
  }
};

export const getDraft = async (): Promise<AxiosResponse<IEvent> | undefined> => {
  try {
    const response = await axios.get<IEvent>(`/EventAdmin/draftCover`);
    return response;
  } catch (error) {
    console.error(error);
    return undefined;
  }
};


export const register = async (userData) => {
  try {
    const response = await axios.post('/Auth/register', userData);
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
    const response = await axios.post('/Auth/login', { email, password });
    localStorage.setItem('token', response.data.token);
    return {
      success: true,
      data: response.data,
      message: 'Login successful',
    };
  } 
  catch (error) {
    return {
      success: false,
      data: error.response.data,
      message: 'Login failed',
    };
  }
};

export const getEvent = async (id?: string): Promise<IEvent> => {
  try {
    console.log(id);
    if (id === undefined) {
      throw new Error('Event ID is undefined.');
    }
    const response = await axios.get<IEvent>(`/events/${id}`);
    return await fetchEventCover(response.data);
  } catch (error) {
    console.error(`Error fetching event with id ${id}:`, error);
    throw error;
  }
};

async function fetchEventCover(event: IEvent): Promise<IEvent> {
  try {
    const coverResponse: AxiosResponse<ArrayBuffer> = await axios.get(`/events/${event.id}/cover`, { responseType: 'arraybuffer' });
    const blob = new Blob([coverResponse.data], { type: 'image/*' });
    return { ...event, img: blob };
  }
  catch (error) {
    return event;
  }
}

export const findUsers = async (username: string) => {
  try {
    const response = await axios.get<string[]>(`/users?username=${username}`);
    return response.data;
  } catch (error) {
    console.error(error);
  }
};

export const addInspector = async (event: IEvent, username: string) => {
  try {
    const response = await axios.put(`/events/${event.id}/inspectorByUsername`, { username: username});
    return response.data;
  } catch (error) {
    console.error(error);
  }
};

export const deleteInspector = async (event: IEvent, username: string) => {
  try {
    const response = await axios.delete(`/events/${event.id}/inspector?username=${username}`);
    return response.data;
  } catch (error) {
    console.error(error);
  }
};

export const getInspectors = async (event: IEvent) => {
  try {
    const response = await axios.get<string[]>(`/events/${event.id}/inspectors`);
    return response.data;
  } catch (error) {
    console.error(error);
  }
};


