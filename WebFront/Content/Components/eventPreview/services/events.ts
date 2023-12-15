import { IEventsResponse } from '../models';

export const getEvents = async () => {
  let response: IEventsResponse;

  response = require('../static/json/events.json');

  const { events } = response.data;

  return events;
};
