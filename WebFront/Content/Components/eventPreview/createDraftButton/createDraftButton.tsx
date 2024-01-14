import React from 'react';
import { createDraft } from '../services/events';
import { Button } from '@skbkontur/react-ui';
import styles from './eventPreview.scss';
import {useNavigate} from "react-router-dom";

export const EventCreateButton = () => {
    const navigate = useNavigate();
    const handleCreateDraft = async () => {
        try {
          
            await createDraft();
            navigate(`/eventAdmin/draft`);
            console.log('Draft created successfully'); 
        } catch (error) {
            console.error('Error creating draft', error);
        }
    };

    return (
        <Button onClick={handleCreateDraft} size={"medium"} >Create Draft</Button>
    );
};
