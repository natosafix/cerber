import React from 'react';
import {IEvent} from '../models/index'
import styles from './event.scss';

interface IProps {
  event: IEvent;
}

const Event = ({ event }: IProps) => {
  const {
      img,
      title
  } = event;

    const handleClick = () => {
        window.location.href = 'https://www.google.com'; // Замените на ваш URL
    };

  return (
        <div className={styles.eventWrapper}>
12
            <div className={styles.imgWrapper}>
                <img  src="https://content-30.foto.my.mail.ru/community/bibliadenjzadnjom/1/h-36648.jpg"/>
            </div>
            <div className={styles.textWrapper}>
                <p>{title}</p>
            </div>
        </div>

  );
};

export default Event