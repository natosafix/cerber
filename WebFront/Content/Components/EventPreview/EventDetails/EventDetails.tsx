import React, { useEffect, useState } from 'react';
import { getEvent } from '../Services/Events';
import { IEvent } from '../Models/IEvent';
import styles from './EventDetails.scss';
import { InspectorEditor } from '../InspectorsEditor/InspectorEditor';
import { Gapped } from '@skbkontur/react-ui';
import { Label } from '../../../Entries/Shared/Label/Label';
import { Button } from '@skbkontur/react-ui';
import { getUserInfo } from '../../../Helpers/UserInfoHelper';
import { Route } from '../../../Utility/Constants';
import { EventDetailsSkeleton } from './EventDetailsSkeleton';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';
import { DraftEvent } from '../../../../Api/EventAdmin/DraftEvent';
import { EventStats } from '../../EventStats/EventStats';

export const EventDetails: React.FC<{ id?: string }> = ({ id }) => {
    const [event, setEvent] = useState<IEvent | null>(null);
    const [imgSrc, setImgSrc] = useState<string | null>(null);
    const [userId, setUserId] = useState<string>();

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            try {
                if (id) {
                    await getEvent(id).then((x) => setEvent(x));
                } else {
                    EventAdminClient.getDraftCover().then(async (x) => {
                        const event = await DraftEvent.fromDto(x.data).toIEvent();
                        setEvent(event);
                    });
                }
            } catch (error) {}
        };

        fetchEventDetailsAndCover();

        const userInfo = getUserInfo();
        if (userInfo) {
            setUserId(userInfo.id);
        }
    }, [id]);

    useEffect(() => {
        const fetchEventCover = async () => {
            try {
                if (event?.img) {
                    const imgSrc = URL.createObjectURL(event.img);
                    setImgSrc(imgSrc);
                }
            } catch (error) {}
        };

        fetchEventCover();
    }, [event]);

    const handleClickButton = () => {
        window.location.href = Route.QUIZ(id);
    };

    if (!event) {
        return (
            <div>
                <EventDetailsSkeleton />
            </div>
        );
    }
    return (
        <div className={styles.pageWrapper}>
            <div className={styles.eventWrapper}>
                <Gapped vertical gap={30}>
                    <div className={styles.imgWrapper}>{imgSrc && <img src={imgSrc} alt={event.name} />}</div>

                    <div className={styles.contentWrapper}>
                        <Gapped vertical gap={30}>
                            <Gapped vertical gap={10}>
                                <Label label={event.name} size={'large'} />
                                <div style={{ opacity: 0.5 }}>
                                    <Label label={`${event.city}, ${event.address}`} size={'small'} />
                                </div>
                            </Gapped>

                            <Gapped vertical gap={8}>
                                {event.description.split('\n').map((line, index) => (
                                    <Label key={index} label={line} size={'small'} />
                                ))}
                            </Gapped>

                            {userId === event.ownerId && id && <InspectorEditor event={event} />}
                            {id && (
                                <Button size={'large'} use="success" onClick={handleClickButton}>
                                    Заполнить анкету
                                </Button>
                            )}
                            <EventStats event={event} />
                        </Gapped>
                    </div>
                </Gapped>
            </div>
        </div>
    );
};
