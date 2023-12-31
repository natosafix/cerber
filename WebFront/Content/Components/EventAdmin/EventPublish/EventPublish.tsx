﻿import React from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';

interface Props {
    onSave: () => void;
}

export const EventPublish: React.FC<Props> = ({onSave}) => {
    return (
        <div>
            EventPublish
            <EventAdminSaveBtn onSave={onSave} />
        </div>
    );
};