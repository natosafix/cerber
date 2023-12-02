import * as React from 'react';
import styles from './EventAdmin.scss';
import { Button } from '@skbkontur/react-ui';


export const EventStepsNav: React.FC = () => {
    return (
        <div className={styles.stepsWrapper}>
            <Button active={true} borderless={true} size={'medium'}>Описание события</Button>
            <Button active={false} borderless={true} size={'medium'}>Анкета регистрации</Button>
            <Button active={false} borderless={true} size={'medium'}>Публикация</Button>
        </div>
    );
}