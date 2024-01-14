import axios from 'axios';
import { IEvent } from '../models';

export const getEvents = async (): Promise<IEvent[]> => {
  try {
    const response = await axios.get<IEvent[]>('/events/owned');
    return response.data;
  } catch (error) {
    console.error('Error fetching events:', error);
    throw error;
  }
};

export const getEvent = async (id?: string): Promise<IEvent> => {
  try {
    if (id === undefined) {
      throw new Error('Event ID is undefined.');
    }

    const response = await axios.get<IEvent>(`/events/${id}`);
    return response.data;
  } catch (error) {
    console.error(`Error fetching event with id ${id}:`, error);
    throw error;
  }
};

