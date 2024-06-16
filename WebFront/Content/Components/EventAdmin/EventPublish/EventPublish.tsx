import React from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';

interface IEventPublishProps {
    onSave: () => Promise<void>;
}

export const EventPublish: React.FC<IEventPublishProps> = ({ onSave }) => {
    const onSaveBtnClick = async () => {
        await onSave();
    };
    
    return (
        <div>
            <EventAdminSaveBtn onSave={onSaveBtnClick} title={'Опубликовать'} />
        </div>
    );
}