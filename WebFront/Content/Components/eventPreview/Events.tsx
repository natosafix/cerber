import React, { useState } from 'react';
import styles from './events.scss';
import Event from './event/Event';

export const Events = ({ events }) => {
    return (
        <div className={styles.eventsWrapper}>
            {events?.map((event) => (
                <Event event={event} key={event.id} />
            ))}
        </div>
    );
};

