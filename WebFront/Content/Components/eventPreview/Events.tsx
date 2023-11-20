import Event  from './event/Event';
import { IEvent } from './models/index'
import React from 'react';


interface IProps {
  events: IEvent[];
}

const Events = ({ events }: IProps) => {
  return (
      <div>
        {events?.map((p) => (
            <Event event={p} key={p.img} />
        ))}
      </div>
  );
};

export default Events