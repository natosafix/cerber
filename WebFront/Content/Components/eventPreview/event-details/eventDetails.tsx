import React, { useEffect, useState } from 'react';
import { getEvent } from '../services/events';
import { IEvent } from '../models';
import styles from './eventDetails.scss';
import { InspectorEditor } from '../InspectorsEditor/InspectorEditor';
import { Gapped } from '@skbkontur/react-ui';
import { Label } from '../../../Entries/Shared/Label/Label';

export const EventDetails: React.FC<{ id: string | undefined }> = ({ id }) => {
    const [event, setEvent] = useState<IEvent | null>(null);
    const [imgSrc, setImgSrc] = useState<string | null>(null);

    useEffect(() => {
        const fetchEventDetailsAndCover = async () => {
            try {
                if (id) {
                    const eventData = await getEvent(id);
                    console.log('Event Data:', eventData);
                    setEvent(eventData);

                    if (eventData.img) {
                        const imgSrc = URL.createObjectURL(eventData.img);
                        setImgSrc(imgSrc);
                    }
                }
            } catch (error) {
                console.error(error);
            }
        };

        fetchEventDetailsAndCover();
    }, [id]);


    if (!event) {
        return <div>Loading...</div>;
    }
    return (
        <div className={styles.pageWrapper}>
            <div className={styles.eventWrapper}>
                <Gapped vertical gap={30}>
                    <div className={styles.imgWrapper}>
                        {imgSrc && <img src={imgSrc} alt={event.name} />}
                    </div>

                    <div className={styles.contentWrapper}>
                        <Gapped vertical gap={30}>

                            <Gapped vertical gap={10}>
                                <Label label={event.name} size={'large'} />
                                <div style={{ opacity: 0.5 }}>
                                    <Label label={`${event.city}, ${event.address}`} size={'small'} />
                                </div>
                            </Gapped>

                            <Gapped vertical gap={5}>
                                {event.description.split('\n').map((line, index) => (
                                    <Label key={index} label={line} size={'small'} />
                                ))}
                            </Gapped>
                            
                            <InspectorEditor event={event} />
                        </Gapped>
                    </div>
                </Gapped>
            </div>
        </div>
    );
};
