import React, { useEffect, useState } from 'react';
import { createDraft, getDraft } from '../Services/Events';
import { Button } from '@skbkontur/react-ui';
import styles from './CreateDraftButton.scss';
import { Route } from '../../../Utility/Constants';

export const EventCreateButton = () => {
    const handleCreateDraft = async () => {
        try {
            await createDraft();
            window.location.href = Route.DRAFT;
        } catch (error) {
        }
    };

    return (
        <div className={styles.divButton}>
            <Button onClick={handleCreateDraft} use="success" size={'large'}>
                Перейти к черновику
            </Button>
        </div>
    );
};
