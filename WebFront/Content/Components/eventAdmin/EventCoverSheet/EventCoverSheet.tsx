import React, { useRef, useState } from 'react';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { Button, Gapped, Input } from '@skbkontur/react-ui';
import { LocalStorageSaver } from '../../../Helpers/LocalStorageSaver/LocalStorageSaver';
import { SingleStringQuestion } from './Questions/SingleStringQuestion';
import { MultiStringQuestion } from './Questions/MultiStringQuestion';
import { ImageLoader } from './Questions/ImageLoader';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';


interface Props {
    onSave: () => void;
}

export const EventCoverSheet: React.FC<Props> = ({ onSave }) => {
    let localStorageSaver = new LocalStorageSaver('Draft');

    const [eventName, setEventName] = useState('');

    const validWrapper = useRef<ValidationContainer>(null);

    let onClickHandle = async () => {
        if (validWrapper.current) {
            const isValid = await validWrapper.current.validate();
            if (isValid) {
                onSave();
            }
        }
    };

    return (
        <ValidationContainer ref={validWrapper}>
            <Gapped gap={30} vertical={true}>
                <SingleStringQuestion storageSaver={localStorageSaver} title={'Название'} />
                <MultiStringQuestion storageSaver={localStorageSaver} title={'Подробное описание'} />
                <ImageLoader storageSaver={localStorageSaver} title={'Обложка'} />
                <EventAdminSaveBtn onSave={onClickHandle} />
            </Gapped>
        </ValidationContainer>
    );
};