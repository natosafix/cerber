import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { getEvent } from '../services/events';
import { IEvent } from '../models';
import styles from './eventDetails.scss';
import {InspectorEditor} from "../InspectorsEditor/InspectorEditor";

export const EventDetails: React.FC = () => {
    const { id } = useParams();
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
        <div className={styles.eventWrapper}>
            <div className={styles.imgWrapper}>
                {imgSrc && <img src={imgSrc} alt={event.name}/>}
            </div>
            <div className={styles.textWrapper}>
                <p className={styles.title}>{event.name}</p>
                <p className={styles.place}>{event.city}, {event.address}</p>
                <p>{event.description}</p>
            </div>
            <InspectorEditor />
        </div>
    );
};
