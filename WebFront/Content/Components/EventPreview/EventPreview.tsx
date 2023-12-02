import { EventsClient } from '../../Api/EventsClient';
import * as React from 'react';

import styles from './eventPreview.scss';

export const EventPreview: React.FC = () => {
    const events = EventsClient.getEvent("23");
    
    return (
        <div className={styles.eventPreviewWrapper}>
        </div>
    )
}