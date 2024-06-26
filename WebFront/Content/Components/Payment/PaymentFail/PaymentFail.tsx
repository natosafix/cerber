import * as React from 'react';
import { Label } from '../../../Entries/Shared/Label/Label';
import { Button, Gapped } from '@skbkontur/react-ui';
import styles from './PaymentFail.scss';
import { QuizSolveClient } from '../../../../Api/QuizSolve/QuizSolveClient';

export const PaymentFail: React.FC = () => {
    const searchParams = new URLSearchParams(window.location.search);
    const customer = searchParams.get('Shp_customer');

    const redirect = async (customer: string) => {
        window.location.href = await QuizSolveClient.getRetryPaymentUrl(customer).then((url) => url);
    };
    const onNextBtn = () => {
        customer && redirect(customer);
    };

    return (
        <div className={styles.centerWrapper}>
            <Gapped className={styles.textWrapper} vertical gap={20}>
                <Label label={'Платеж завершился с ошибкой!'} size={'large'} />
                <Gapped vertical gap={10}>
                    <Label label={'Пожалуйста, оплатите заказ повторно'} />
                </Gapped>

                <Button onClick={onNextBtn}>Оплатить</Button>
            </Gapped>
        </div>
    );
};
