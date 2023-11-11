import * as React from 'react';
import styles from './eventAdmin.scss';
import { EventStepsNav } from './eventStepsNav';
import { Gapped } from '@skbkontur/react-ui';
import { EventCoverSheet } from './eventCoverSheet';

export const EventAdmin: React.FC = () => {
    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav />
            <EventCoverSheet />
        </div>);
};