import * as React from 'react';
import { Label } from '../../Entries/Shared/Label/Label';
import styles from './Error.scss';
import img from '../../Images/sad_face.png';
import { Button, Gapped } from '@skbkontur/react-ui';
import { Route } from '../../Utility/Constants';

export const Error: React.FC = () => {
    const searchParams = new URLSearchParams(window.location.search);
    const statusCode = searchParams.get('statusCode') ?? '???';

    const onBackBtn = () => {
        window.location.href = Route.INDEX;
    };

    return (
        <div className={styles.centerWrapper}>
            <Gapped vertical gap={15}>
                <img className={styles.img} src={img} alt={'sad smile'} />

                <label className={styles.statusCodeTitle}>{statusCode}</label>
                <label className={styles.opsTitle}>Oops..</label>

                <Gapped vertical gap={5}>
                    <Label label={'Кажется, что-то пошло не так :('} size={'medium'} />
                    <Label label={'Вернитесь на гланую страницу'} size={'medium'} />
                </Gapped>

                <Button use={'primary'} onClick={onBackBtn}>
                    Вернуться
                </Button>
            </Gapped>
        </div>
    );
};
