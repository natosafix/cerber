import React from 'react';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';
import { EventDetails } from '../../EventPreview/EventDetails/EventDetails';
import { Box } from '@mui/material';
import { EventPreviewDetails } from '../../EventPreview/EventDetails/EventPreviewDetails/EventPreviewDetails';

interface IEventPublishProps {
    onSave: () => Promise<void>;
}

export const EventPublish: React.FC<IEventPublishProps> = ({ onSave }) => {
    const onSaveBtnClick = async () => {
        await onSave();
    };

    return (
        <Box sx={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
            <EventPreviewDetails />
            <EventAdminSaveBtn onSave={onSaveBtnClick} title={'Опубликовать'} />
        </Box>
    );
};
