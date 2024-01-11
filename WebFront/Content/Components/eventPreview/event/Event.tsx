import React, { useState } from 'react';
import { IEvent } from '../models/index';
import styles from './event.scss';

interface IProps {
    event: IEvent;
}

const Event = ({ event }: IProps) => {
    const { img, title } = event;
    const [isHovered, setIsHovered] = useState(false);

    const handleClick = () => {
        window.location.href = 'https://www.google.com';
    };

    return (
        <div
            className={styles.eventWrapper}
            onClick={handleClick}
            onMouseEnter={() => setIsHovered(true)}
            onMouseLeave={() => setIsHovered(false)}
            style={{ cursor: isHovered ? 'pointer' : 'default' }}
        >
            <div className={styles.imgWrapper}>
                <img src="https://content-30.foto.my.mail.ru/community/bibliadenjzadnjom/1/h-36648.jpg" />
            </div>
            <div className={styles.textWrapper}>
                <p>{title}</p>
            </div>
        </div>
    );
};

export default Event;