import React, {useEffect, useRef, useState} from 'react';
import {ValidationContainer} from '@skbkontur/react-ui-validations';
import {Button, Gapped, Input} from '@skbkontur/react-ui';
import {LocalStorageSaver} from '../../../Helpers/LocalStorageSaver/LocalStorageSaver';
import {SingleStringQuestion} from '../Questions/SingleStringQuestion';
import {MultiStringQuestion} from '../Questions/MultiStringQuestion';
import {ImageLoader} from '../Questions/ImageLoader';
import {EventAdminSaveBtn} from '../EventStepsNav/EventAdminSaveBtn';
import {EventAdminClient} from "../../../../Api/EventAdmin/EventAdminClient";
import {DraftEvent} from "../../../../Api/EventAdmin/DraftEvent";


interface Props {
    onSave: () => void;
    draftId: string;
}

export const EventCoverSheet: React.FC<Props> = ({onSave, draftId}) => {
    let localStorageSaver = new LocalStorageSaver('Draft');

    const [draft, setDraft] = useState<DraftEvent>();

    useEffect(() => {
        EventAdminClient.getDraftCover(draftId).then(r => alert(r));
    }, [])

    const validWrapper = useRef<ValidationContainer>(null);

    let onClickHandle = async () => {
        if (validWrapper.current) {
            const isValid = await validWrapper.current.validate();
            if (isValid) {
                await EventAdminClient.setDraftCover(draftId, draft!);
                onSave();
            }
        }
    };

    const onTitleChange = (v: string) => {
        alert(`Save title: ${JSON.stringify(draft)}}`)
        alert(`Save title: ${draft?.OwnerId}}`)
        setDraft(draft?.withTitle(v));
    }

    return (
        <ValidationContainer ref={validWrapper}>
            <Gapped gap={30} vertical={true}>
                <SingleStringQuestion title={'Название'}
                                      defaultValue={draft?.Title}
                                      onValueChange={onTitleChange}/>
                <MultiStringQuestion storageSaver={localStorageSaver}
                                     title={'Подробное описание'}/>
                <ImageLoader storageSaver={localStorageSaver}
                             title={'Обложка'}/>
                <EventAdminSaveBtn onSave={onClickHandle}/>
            </Gapped>
        </ValidationContainer>
    );
};