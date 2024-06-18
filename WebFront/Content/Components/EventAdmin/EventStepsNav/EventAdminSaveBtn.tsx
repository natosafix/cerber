import React from 'react';
import { Button } from '@skbkontur/react-ui';

interface Props {
    onSave: () => void;
    title?: string;
}

export const EventAdminSaveBtn: React.FC<Props> = (
    {
        onSave,
        title = 'Сохранить'
    }) => {

    return (
        <Button use={'primary'}
                size={'medium'}
                onClick={onSave}
        >
            {title}
        </Button>
    );
};