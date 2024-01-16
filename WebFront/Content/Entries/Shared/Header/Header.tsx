import * as React from 'react';
import { Button, Gapped } from '@skbkontur/react-ui';
import styles from './header.scss';
import {getUserInfo} from "../../../Helpers/UserInfoHelper";
import {useState} from "react";

export const Header: React.FC = () => {
    const [userName, setUserName] = React.useState('');
    const [buttonText, setButtonText] = React.useState("Войти");
    const [isHovered, setIsHovered] = useState(false);

    const handleClickLogo = () => {
        window.location.href = `/home/index`;
    };
    const handleClickLogOut = () => {
        if (buttonText === "Выйти" || buttonText === "Войти"){
            window.location.href = `/home/login`;
            deleteCookie("CerberAuth");
        }
        else{
            window.location.href = `/home/register`;
        }
    };
    const deleteCookie = (name) => {
        document.cookie = name + "=; Path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC;";
    };

    React.useEffect(() => {
        const userInfo = getUserInfo();
        if (userInfo) {
            setUserName(userInfo.username);
            setButtonText("Выйти")
        }
        else if (window.location.href.includes("/home/login"))
        {
            setButtonText("Регистрация") 
        }
    }, []);

    return (
        <div className={styles.headerWrapper}>
            <p onMouseEnter={() => setIsHovered(true)}
               onMouseLeave={() => setIsHovered(false)}
               style={{ cursor: isHovered ? 'pointer' : 'default' }}
               className={styles.logo}
               onClick={handleClickLogo}>CERBER</p>
            <Gapped gap={20} verticalAlign={'middle'}>
                {userName && <Button size={'medium'} use={'text'}>{userName}</Button>}
                <Button size={'medium'} onClick={handleClickLogOut}>{buttonText}</Button>
            </Gapped>
        </div>
    );
};
