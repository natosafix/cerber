import React, { useEffect, useRef, useState } from 'react';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { Gapped } from '@skbkontur/react-ui';
import { EventAdminSaveBtn } from '../EventStepsNav/EventAdminSaveBtn';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';
import { DraftEvent } from '../../../../Api/EventAdmin/DraftEvent';
import { MultiStringQuestion } from '../../../Entries/Shared/Questions/MultiStringQuestion';
import { SingleStringQuestion } from '../../../Entries/Shared/Questions/SingleStringQuestion';
import { DateTimeQuestion } from '../../../Entries/Shared/Questions/DateTimeQuestion';
import { ImageLoader } from '../../../Entries/Shared/Questions/ImageLoader';

interface Props {
    onSave: () => void;
}

export const EventCoverSheet: React.FC<Props> = ({ onSave }) => {
    const [draft, setDraft] = useState<DraftEvent>();

    useEffect(() => {
        EventAdminClient.getDraftCover().then(r => {
            const loadedDraft = DraftEvent.fromDto(r.data);
            setDraft(loadedDraft);
        });
    }, []);

    const validWrapper = useRef<ValidationContainer>(null);

    const onClickHandle = async () => {
        if (validWrapper.current) {
            const isValid = await validWrapper.current.validate();
            if (isValid) {
                await EventAdminClient.setDraftCover(draft!);
                onSave();
            }
        }
    };

    const onImgRemove = async () => {
        await EventAdminClient.removeCoverImage();
    };

    if (!draft) {
        return null;
    }

    return (
        <ValidationContainer ref={validWrapper}>
            <Gapped gap={30} vertical={true}>
                <SingleStringQuestion title={'Название'}
                                      defaultValue={draft?.Title}
                                      onValueChange={(v) => setDraft(draft?.withTitle(v))} />
                <MultiStringQuestion title={'Подробное описание'}
                                     defaultValue={draft?.Description}
                                     onValueChange={(v) => setDraft(draft?.withDescription(v))} />
                <SingleStringQuestion title={'Город'}
                                      defaultValue={draft?.City}
                                      onValueChange={(v) => setDraft(draft?.withCity(v))} />
                <SingleStringQuestion title={'Место'}
                                      defaultValue={draft?.Address}
                                      onValueChange={(v) => setDraft(draft?.withAddress(v))} />
                <DateTimeQuestion title={'Дата и время'}
                                  onValueChange={(v) => setDraft(draft?.withFrom(v))} 
                                  defaultValue={draft?.From}/>
                <ImageLoader title={'Обложка'}
                             uploader={EventAdminClient.setCoverImage}
                             defaultUrl={draft.CoverImageId ? EventAdminClient.getCoverImageUrl() : null}
                             onRemove={onImgRemove} />
                <EventAdminSaveBtn onSave={onClickHandle} />
            </Gapped>
        </ValidationContainer>
    );
};