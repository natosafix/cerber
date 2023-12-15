import React from 'react';
import { Button } from '@skbkontur/react-ui';

interface Props {
    onSave: () => void;
}

export const EventAdminSaveBtn: React.FC<Props> = ({onSave}) => {

    return (
        <Button use={'primary'}
                size={'medium'}
                onClick={onSave}
        >
            Сохранить
        </Button>
    );
};