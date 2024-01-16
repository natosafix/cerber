import * as React from 'react';
import { Button, Gapped } from '@skbkontur/react-ui';
import styles from './header.scss';
import {getUserInfo} from "../../../Helpers/UserInfoHelper";

export const Header: React.FC = () => {
    const [userName, setUserName] = React.useState('');

    const handleClickLogo = () => {
        window.location.href = `/home/index`;
    };

    const handleClickLogOut = () => {
        window.location.href = `/home/login`;
        deleteCookie("CerberAuth");
    };

    const deleteCookie = (name) => {
        document.cookie = name + "=; Path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
    };

    React.useEffect(() => {
        const userInfo = getUserInfo();
        if (userInfo) {
            setUserName(userInfo.username);
        }
    }, []);

    return (
        <div className={styles.headerWrapper}>
            <p className={styles.logo} onClick={handleClickLogo}>CERBER</p>
            <Gapped gap={20} verticalAlign={'middle'}>
                <Button size={'medium'} use={'text'}>{userName || 'Иванов Иван'}</Button>
                <Button size={'medium'} onClick={handleClickLogOut}>Выйти</Button>
            </Gapped>
        </div>
    );
};
