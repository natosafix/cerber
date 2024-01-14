import React, { useState } from 'react';
import { IEvent } from '../models/index';
import styles from './event.scss';
import { useNavigate } from 'react-router-dom';

interface IProps {
    event: IEvent;
}

const Event: React.FC<IProps> = ({ event }) => {
    const { id, img, name, address, city, from, to } = event;
    const [isHovered, setIsHovered] = useState(false);
    const fromDate = new Date(from);
    const navigate = useNavigate();

    const handleClick = () => {
        navigate(`/home/preview/${id}`);
    };

    return (
        <div
            className={styles.eventWrapper}
            onMouseEnter={() => setIsHovered(true)}
            onMouseLeave={() => setIsHovered(false)}
            style={{ cursor: isHovered ? 'pointer' : 'default' }}
            onClick={handleClick}
        >
            <div className={styles.imgWrapper}>
                <img src="https://content-30.foto.my.mail.ru/community/bibliadenjzadnjom/1/h-36648.jpg" alt={name} />
            </div>
            <div className={styles.textWrapper}>
                <p className={styles.title}>{name}</p>
                <p className={styles.place}>{city}, {address}</p>
                <p className={styles.time}>{formatDate(fromDate)}</p>
            </div>
        </div>
    );
};

function formatDate(date) {
    const day = ('0' + date.getDate()).slice(-2);
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const year = date.getFullYear();

    return `${day}.${month}.${year}`;
}

export default Event;
