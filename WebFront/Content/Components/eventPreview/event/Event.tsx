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
  return (
    <div className={styles.imgWrapper}>
      <img className={styles.imgWrapper}  src="https://content-30.foto.my.mail.ru/community/bibliadenjzadnjom/1/h-36648.jpg"/>
        {event.title}
    </div>
  );
};

export default Event