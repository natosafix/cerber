import React, { useState } from 'react';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { Button, Gapped, Input } from '@skbkontur/react-ui';
import styles from './eventAdmin.scss';
import { LocalStorageSaver } from '../../Helpers/LocalStorageSaver/LocalStorageSaver';
import { SingleStringQuestion } from './questions/singleStringQuestion';


export const EventCoverSheet: React.FC = () => {
    let localStorageSaver = new LocalStorageSaver('Draft');

    const [eventName, setEventName] = useState('');

    return (
        <div className={styles.contentWrapper}>
            <ValidationContainer>
                <Gapped gap={30} vertical={true}>
                    <SingleStringQuestion storageSaver={localStorageSaver} title={'Название'} />
                    <SingleStringQuestion storageSaver={localStorageSaver} title={'Описание'} />
                </Gapped>
                <Button type={'submit'}>Отправить</Button>
            </ValidationContainer>
        </div>
    );
};