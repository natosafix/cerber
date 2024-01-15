import React, { useEffect, useState  } from 'react';
import { createDraft, getDraft } from '../services/events';
import { Button } from '@skbkontur/react-ui';
import styles from './createDraftButton.scss';

export const EventCreateButton = () => {
    const [name, setName] = useState("Создать черновик");

    const handleCreateDraft = async () => {
        try {
            await createDraft();
            window.location.href = "/eventAdmin/draft";
        } catch (error) {
            setName("Перейти к черновику")
        }
    };

    const onLoad = async () => {
        try {
            const draftResponse = await getDraft();
            if (draftResponse != undefined && draftResponse.status === 200){
                setName("Перейти к черновику")
            }
        } catch (error) {
            console.error('Error creating draft', error);
        }
    };

    useEffect(() => {
        onLoad();
    }, []);

    return (
        <div className={styles.divButton}>
            <Button onClick={handleCreateDraft} use="success" size={"large"} >{name}</Button>
        </div>
    );
};
