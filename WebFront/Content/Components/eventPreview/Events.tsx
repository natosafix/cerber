// Events.tsx

import Event from './event/Event';
import { IEvent } from './models';
import React from 'react';
import styles from './events.scss'

interface IProps {
    events: IEvent[];
}

const Events = ({ events }: IProps) => {
    return (
        <div className={styles.eventsWrapper}>
            {events?.map((p) => (
                <Event event={p} key={p.img} />
            ))}
        </div>
    );
};

export default Events;
