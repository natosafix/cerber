import React, { useState } from 'react';
import styles from './events.scss';
import Event from './event/Event';

const Events = ({ events }) => {
    return (
        <div>
            <div className={styles.eventsWrapper}>
                {events?.map((p) => (
                    <Event event={p} key={p.img} />
                ))}
            </div>
        </div>
    );
};

export default Events;
