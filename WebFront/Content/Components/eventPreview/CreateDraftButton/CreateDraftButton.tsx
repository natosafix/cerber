import React, { useEffect, useState } from 'react';
import { createDraft, getDraft } from '../Services/Events';
import { Button } from '@skbkontur/react-ui';
import styles from './CreateDraftButton.scss';
import { Route } from '../../../Utility/Constants';

export const EventCreateButton = () => {
    const [name, setName] = useState('Создать черновик');

    const handleCreateDraft = async () => {
        try {
            await createDraft();
            window.location.href = Route.DRAFT;
        } catch (error) {
            setName('Перейти к черновику');
        }
    };

    const onLoad = async () => {
        try {
            const draftResponse = await getDraft();
            if (draftResponse != undefined && draftResponse.status === 200) {
                setName('Перейти к черновику');
            }
        } catch (error) {}
    };

    useEffect(() => {
        onLoad();
    }, []);

    return (
        <div className={styles.divButton}>
            <Button onClick={handleCreateDraft} use="success" size={'large'}>
                {name}
            </Button>
        </div>
    );
};
