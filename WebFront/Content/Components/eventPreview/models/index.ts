export interface IEvent {
  img: number;
  title: string;
}

export interface IEventsResponse {
  data: {
    events: IEvent[];
  };
}
