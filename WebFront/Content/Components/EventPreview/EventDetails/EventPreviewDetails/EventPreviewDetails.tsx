import React, { useEffect, useRef, useState } from 'react';
import { IEvent } from '../../Models/IEvent';
import styles from './EventPreviewDetails.scss';
import { InspectorEditor } from '../../InspectorsEditor/InspectorEditor';
import { Gapped } from '@skbkontur/react-ui';
import { Label } from '../../../../Entries/Shared/Label/Label';
import { Button } from '@skbkontur/react-ui';
import { Route } from '../../../../Utility/Constants';
import { EventPreviewDetailsSkeleton } from './EventPreviewDetailsSkeleton';
import { getEvent } from '../../Services/Events';
import { EventAdminClient } from '../../../../../Api/EventAdmin/EventAdminClient';
import { DraftEvent } from '../../../../../Api/EventAdmin/DraftEvent';

export const EventPreviewDetails: React.FC<{ userId?: string; event?: IEvent | null }> = ({ userId, event }) => {
    const [imgSrc, setImgSrc] = useState<string | null>(null);
    const [currentEvent, setCurrentEvent] = useState<IEvent | null | undefined>(event);
    const firstRender = useRef(true);

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            if (firstRender.current) {
                firstRender.current = false;

                if (currentEvent == undefined) {
                    EventAdminClient.getDraftCover().then(async (x) => {
                        const event = await DraftEvent.fromDto(x.data).toIEvent();
                        console.log('EVENT');
                        setCurrentEvent(event);
                        if (
                            event?.img &&
                            (event.img.type === 'application/octet-stream' || event.img.type === 'image/*')
                        ) {
                            const imgSrc = URL.createObjectURL(event.img);
                            setImgSrc(imgSrc);
                        }
                    });
                } else {
                    try {
                        if (
                            currentEvent?.img &&
                            (currentEvent.img.type === 'application/octet-stream' ||
                                currentEvent.img.type === 'image/*')
                        ) {
                            const imgSrc = URL.createObjectURL(currentEvent.img);
                            setImgSrc(imgSrc);
                        }
                    } catch (error) {}
                }
                return;
            }
        };

        fetchEventDetailsAndCover();
    }, [currentEvent]);

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            console.log(imgSrc);
        };

        fetchEventDetailsAndCover();
    }, [imgSrc]);

    const handleClickButton = () => {
        window.location.href = Route.QUIZ(currentEvent?.id.toString());
    };

    if (!currentEvent) {
        return (
            <div>
                <EventPreviewDetailsSkeleton />
            </div>
        );
    }
    return (
        <div className={styles.pageWrapper}>
            <div className={styles.eventWrapper}>
                <Gapped vertical>
                    {imgSrc && (
                        <div className={styles.imgWrapper}>
                            <img src={imgSrc} alt={currentEvent.name} />
                        </div>
                    )}

                    <div className={styles.contentWrapper}>
                        <Gapped vertical gap={30}>
                            <Gapped vertical gap={10}>
                                <Label label={currentEvent.name} size={'large'} />
                                <div style={{ opacity: 0.5 }}>
                                    <Label label={`${currentEvent.city}, ${currentEvent.address}`} size={'small'} />
                                </div>
                            </Gapped>

                            <Gapped vertical gap={8}>
                                {currentEvent.description.split('\n').map((line, index) => (
                                    <Label key={index} label={line} size={'small'} />
                                ))}
                            </Gapped>

                            {userId === currentEvent?.ownerId && currentEvent?.id && (
                                <InspectorEditor event={currentEvent} />
                            )}
                            {currentEvent?.id && (
                                <Button size={'large'} use="success" onClick={handleClickButton}>
                                    Заполнить анкету
                                </Button>
                            )}
                        </Gapped>
                    </div>
                </Gapped>
            </div>
        </div>
    );
};
