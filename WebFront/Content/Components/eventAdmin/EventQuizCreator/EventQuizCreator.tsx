import React from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';

interface Props {
    onSave: () => void;
}

export const EventQuizCreator: React.FC<Props> = ({onSave}) => {
    return (
        <div>
            EventQuizCreator
            <EventAdminSaveBtn onSave={onSave} />
        </div>
    );
};