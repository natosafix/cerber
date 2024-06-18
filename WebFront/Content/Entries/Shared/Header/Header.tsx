import * as React from 'react';
import { Gapped } from '@skbkontur/react-ui';
import styles from './header.scss';
import { getUserInfo } from '../../../Helpers/UserInfoHelper';
import { Route } from '../../../Utility/Constants';
import { MaxWidthWrapper } from '../Wrappers/MaxWidthWrapper';
import { Button, SxProps, Theme } from '@mui/material';
const buttonStyle: SxProps<Theme> = {
    color: '#000000',
    fontWeight: 'bold',
    '&:hover': {
        backgroundColor: 'rgb(124,124,124, 0.1)',
    },
};

export const Header: React.FC = () => {
    const [userName, setUserName] = React.useState('');
    const [buttonText, setButtonText] = React.useState('Войти');

    const handleClickLogo = () => {
        window.location.href = Route.INDEX;
    };

    const handleClickMyEvents = () => {
        window.location.href = Route.MY_EVENTS;
    };

    const handleClickLogOut = () => {
        if (buttonText === 'Выйти' || buttonText === 'Войти') {
            window.location.href = Route.LOGIN;
            deleteCookie('CerberAuth');
        } else {
            window.location.href = Route.REGISTER;
        }
    };
    const deleteCookie = (name: string) => {
        document.cookie = name + '=; Path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC;';
    };

    React.useEffect(() => {
        const userInfo = getUserInfo();
        if (userInfo) {
            setUserName(userInfo.username);
            setButtonText('Выйти');
        } else if (window.location.href.includes(Route.LOGIN)) {
            setButtonText('Регистрация');
        }
    }, []);

    return (
        <div className={styles.headerWrapper}>
            <MaxWidthWrapper>
                <div className={styles.headerSpaceBetweenWrapper}>
                    <Gapped gap={20} verticalAlign={'middle'}>
                        <p className={styles.logo} onClick={handleClickLogo}>
                            CERBER
                        </p>

                        <Button sx={buttonStyle} size={'medium'} onClick={handleClickLogo}>
                            {'Мероприятия'}
                        </Button>
                        {userName && (
                            <Button size={'medium'} sx={buttonStyle} onClick={handleClickMyEvents}>
                                Мои мероприятия
                            </Button>
                        )}
                    </Gapped>
                    <Gapped gap={20} verticalAlign={'middle'}>
                        {userName && (
                            <Button sx={buttonStyle} size={'medium'}>
                                {userName}
                            </Button>
                        )}
                        <Button sx={buttonStyle} size={'medium'} onClick={handleClickLogOut}>
                            {buttonText}
                        </Button>
                    </Gapped>
                </div>
            </MaxWidthWrapper>
        </div>
    );
};
