import * as React from 'react';
import { Button, Gapped } from '@skbkontur/react-ui';
import styles from './header.scss';
import { getUserInfo } from '../../../Helpers/UserInfoHelper';
import { Route } from '../../../Utility/Constants';
import { MaxWidthWrapper } from '../Wrappers/MaxWidthWrapper';

export const Header: React.FC = () => {
    const [userName, setUserName] = React.useState('');
    const [buttonText, setButtonText] = React.useState('Войти');

    const handleClickLogo = () => {
        window.location.href = Route.INDEX;
    };
    const handleClickLogOut = () => {
        if (buttonText === 'Выйти' || buttonText === 'Войти') {
            window.location.href = Route.LOGIN;
            deleteCookie('CerberAuth');
        } else {
            window.location.href = Route.REGISTER;
        }
    };
    const deleteCookie = (name) => {
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
                    <p className={styles.logo} onClick={handleClickLogo}>
                        CERBER
                    </p>
                    <Gapped gap={20} verticalAlign={'middle'}>
                        {userName && (
                            <Button size={'medium'} use={'text'}>
                                {userName}
                            </Button>
                        )}
                        <Button size={'medium'} onClick={handleClickLogOut}>
                            {buttonText}
                        </Button>
                    </Gapped>
                </div>
            </MaxWidthWrapper>
        </div>
    );
};
