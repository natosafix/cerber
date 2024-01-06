import React, {useEffect, useRef, useState} from 'react';
import {ValidationContainer} from '@skbkontur/react-ui-validations';
import {Gapped} from '@skbkontur/react-ui';
import {SingleStringQuestion} from '../Questions/SingleStringQuestion';
import {MultiStringQuestion} from '../Questions/MultiStringQuestion';
import {ImageLoader} from '../Questions/ImageLoader';
import {EventAdminSaveBtn} from '../EventStepsNav/EventAdminSaveBtn';
import {EventAdminClient} from "../../../../Api/EventAdmin/EventAdminClient";
import {DraftEvent} from "../../../../Api/EventAdmin/DraftEvent";


interface Props {
    onSave: () => void;
}

export const EventCoverSheet: React.FC<Props> = ({onSave}) => {
    const [draft, setDraft] = useState<DraftEvent>();

    useEffect(() => {
        EventAdminClient.getDraftCover().then(r => {
            setDraft(DraftEvent.fromDto(r.data));
        });
    }, [])

    const validWrapper = useRef<ValidationContainer>(null);

    let onClickHandle = async () => {
        if (validWrapper.current) {
            const isValid = await validWrapper.current.validate();
            if (isValid) {
                await EventAdminClient.setDraftCover(draft!);
                onSave();
            }
        }
    };

    if (!draft) {
        return null;
    }

    return (
        <ValidationContainer ref={validWrapper}>
            <Gapped gap={30} vertical={true}>
                <SingleStringQuestion title={'Название'}
                                      defaultValue={draft?.Title}
                                      onValueChange={(v) => setDraft(draft?.withTitle(v))}/>
                <MultiStringQuestion title={'Подробное описание'}
                                     defaultValue={draft?.Description}
                                     onValueChange={(v) => setDraft(draft?.withDescription(v))}/>
                {/*<ImageLoader title={'Обложка'}/>*/}
                <EventAdminSaveBtn onSave={onClickHandle}/>
            </Gapped>
        </ValidationContainer>
    );
};