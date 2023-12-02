import * as React from 'react';
import styles from './EventAdmin.scss';
import { EventStepsNav } from './EventStepsNav';
import { EventCoverSheet } from './EventCoverSheet';

export const EventAdmin: React.FC = () => {
    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav />
            <EventCoverSheet />
        </div>);
};