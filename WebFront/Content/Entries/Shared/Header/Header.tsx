import * as React from 'react';
import { Button, Gapped } from '@skbkontur/react-ui';

import styles from './header.scss';
// import {useNavigate} from "react-router-dom";

export const Header: React.FC = () => {
    // const navigate = useNavigate();

    // const handleClick = () => {
    //     navigate(`/home/index`);
    // };
    
    return (
        <div className={styles.headerWrapper}>
            <p className={styles.logo}>CERBER</p>
            <Gapped gap={20} verticalAlign={'middle'}>
                <Button size={'medium'} use={'text'}>Иванов Иван</Button>
                <Button size={'medium'}>Выйти</Button>
            </Gapped>
        </div>);
};