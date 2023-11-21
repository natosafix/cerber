﻿import React, { useContext, useRef, useState } from 'react';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { Button, Gapped, Input } from '@skbkontur/react-ui';
import styles from './eventAdmin.scss';
import { LocalStorageSaver } from '../../Helpers/LocalStorageSaver/LocalStorageSaver';
import { SingleStringQuestion } from './questions/singleStringQuestion';
import { MultiStringQuestion } from './questions/multiStringQuestion';
import { ImageLoader } from './questions/imageLoader';


export const EventCoverSheet: React.FC = () => {
    let localStorageSaver = new LocalStorageSaver('Draft');

    const [eventName, setEventName] = useState('');

    const validWrapper = useRef<ValidationContainer>(null);

    let onClickHandle = async () => {
        if (validWrapper.current) {
            await validWrapper.current.validate();
        }
    };

    return (
        <div className={styles.contentWrapper}>
            <ValidationContainer ref={validWrapper}>
                <Gapped gap={30} vertical={true}>
                    <SingleStringQuestion storageSaver={localStorageSaver} title={'Название'} />
                    <SingleStringQuestion storageSaver={localStorageSaver} title={'Название2'} />
                    <MultiStringQuestion storageSaver={localStorageSaver} title={'Подробное описание'} />
                    <ImageLoader storageSaver={localStorageSaver} title={'Обложка'} />
                </Gapped>
                <Button type={'submit'} onClick={onClickHandle}>Отправить</Button>
            </ValidationContainer>
        </div>
    );
};