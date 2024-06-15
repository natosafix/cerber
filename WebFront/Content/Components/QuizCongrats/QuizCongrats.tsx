import * as React from 'react';
import { Label } from '../../Entries/Shared/Label/Label';
import { Button, Gapped } from '@skbkontur/react-ui';
import styles from './QuizCongrats.scss';
import { QuizSolveClient } from '../../../Api/QuizSolve/QuizSolveClient';

export const QuizCongrats: React.FC = () => {
    const searchParams = new URLSearchParams(window.location.search);
    const eventId = searchParams.get('Shp_eventId');

    const onNextBtn = () => {
        window.location.href = QuizSolveClient.getEventDetailsUrl(Number(eventId));
    };

    return (
        <div className={styles.centerWrapper}>
            <Gapped vertical gap={20}>
                <Label label={'Спасибо за регистрацию на мероприятие!'} size={'large'} />
                <Gapped vertical gap={10}>
                    <Label label={'Ваша анкета успешно зарегистрирована'} />
                    <Label
                        label={
                            'В ближайшее время на указанный вами адрес электронной ' +
                            'почты придет билет для участия в мероприятии'
                        }
                    />
                </Gapped>

                <Button onClick={onNextBtn}>Вернуться к мероприятию</Button>
            </Gapped>
        </div>
    );
};
