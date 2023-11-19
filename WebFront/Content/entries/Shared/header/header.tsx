import * as React from 'react';
import { Button, Gapped } from '@skbkontur/react-ui';

import styles from './header.scss';

export const Header: React.FC = () => {
    return (
        <div className={styles.headerWrapper}>
            <p className={styles.logo}>CERBER</p>
            <Gapped gap={20} verticalAlign={'middle'}>
                <Button size={'medium'} use={'text'}>Иванов Иван</Button>
                <Button size={'medium'}>Выйти</Button>
            </Gapped>
        </div>);
};