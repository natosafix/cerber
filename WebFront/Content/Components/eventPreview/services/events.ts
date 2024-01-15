
import axios, { AxiosResponse } from 'axios';
import { IEvent } from '../models';

let shouldSendNextRequest = true;

export const getEvents = async (count: number): Promise<IEvent[]> => {
  try {
    if (!shouldSendNextRequest) {
      return [];
    }

    console.log(count);
    const response = await axios.get<IEvent[]>(`/events/owned?offset=${count}&limit=${count + 6}`);

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

export const getEvent = async (id?: string): Promise<IEvent> => {
  try {
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

