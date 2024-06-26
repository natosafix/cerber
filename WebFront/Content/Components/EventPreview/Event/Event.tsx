import React, { useState, useEffect } from 'react';
import { IEvent } from '../Models/IEvent';
import styles from './Event.scss';
import { Route } from '../../../Utility/Constants';

interface IProps {
    event: IEvent;
}

const Event: React.FC<IProps> = ({ event }) => {
    const { id, img, name, address, city, from, to } = event;
    const [isHovered, setIsHovered] = useState(false);
    const [imgSrc, setImgSrc] = useState<string | null>(null);

    const fromDate = new Date(from);

    useEffect(() => {
        const fetchEventCover = async () => {
            try {
                setImgSrc(URL.createObjectURL(img));
            } catch (error) {}
        };
        fetchEventCover();
    }, [id]);

    const handleClick = () => {
        window.location.href = Route.PREVIEW(id);
    };

    return (
        <div className={styles.eventWrapper} onClick={handleClick}>
            <div className={styles.imgWrapper}>
                <div className={styles.imgWrapper}>{imgSrc && <img src={imgSrc} alt={name} />}</div>
            </div>
            <div className={styles.textWrapper}>
                <div className={styles.titleWrapper}>
                    <p className={styles.title}>{name}</p>
                </div>
                <p className={styles.place}>
                    {city}, {address}
                </p>
                <p className={styles.time}>{formatDate(fromDate)}</p>
            </div>
        </div>
    );
};

function formatDate(date: Date) {
    const day = ('0' + date.getDate()).slice(-2);
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const year = date.getFullYear();
    const hours = ('0' + date.getHours()).slice(-2);
    const minutes = ('0' + date.getMinutes()).slice(-2);

    return `${day}.${month}.${year} ${hours}:${minutes}`;
}

export default Event;
