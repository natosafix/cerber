import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { getEvent } from '../services/events';
import { IEvent } from '../models';
import styles from './eventDetails.scss';

export const EventDetails: React.FC = () => {
    const { id } = useParams();
    const [event, setEvent] = useState<IEvent | null>(null);
    const [hasCerberAuthCookie, setHasCerberAuthCookie] = useState(false);

    useEffect(() => {
        const fetchEventDetails = async () => {
            if (id) {
                try {
                    const eventData = await getEvent(id);
                    console.log('Event Data:', eventData);
                    setEvent(eventData);
                } catch (error) {
                    return <div>Такого события не существует</div>;
                }
            }
        };
        const checkCerberAuthCookie = () => {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.startsWith('CerberAuth=')) {
                    setHasCerberAuthCookie(true);
                    break;
                }
            }
        };
        
        checkCerberAuthCookie();
        fetchEventDetails();
    }, [id]);

    if (!event) {
        return <div>Loading...</div>;
    }

    return (
        <div className={styles.eventWrapper}>
            <div className={styles.imgWrapper}>
                <img src="https://content-30.foto.my.mail.ru/community/bibliadenjzadnjom/1/h-36648.jpg" />
            </div>
            <div className={styles.textWrapper}>
                <p className={styles.title}>{event.name}</p>
                <p className={styles.place}>{event.city}, {event.address}</p>
                <p>{event.description}</p>
            </div>
        </div>
    );
};

export default EventDetails;
