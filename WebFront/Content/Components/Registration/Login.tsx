import React, { useState, useRef } from 'react';

import { EmailInput } from './Inputs/EmailInput';
import { PasswordInput } from './Inputs/PasswordInput';
import { login } from '../EventPreview/Services/Events';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import styles from './Login.scss';
import { GetLoadingButtonStyle, Route } from '../../Utility/Constants';
import LoadingButton from '@mui/lab/LoadingButton';
import { ClosingAlert } from '../../Entries/Shared/Alert/ClosingAlert';

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState<boolean>(false);
    const validWrapper = useRef<ValidationContainer>(null);

    if (get_cookie('CerberAuth')) {
        window.location.href = Route.INDEX;
    }
    const handleLogin = async () => {
        try {
            if (validWrapper.current) {
                const isValid = await validWrapper.current.validate();
                if (isValid) {
                    const result = await login({ email, password });
                    if (!result.success) {
                        setError('Неверные данные!');
                    } else {
                        setCookie('userName', email);
                        window.location.href = Route.INDEX;
                    }
                }
            }
        } catch (error) {}
    };

    const setCookie = (name: string, value: string) => {
        document.cookie = name + '=' + value + '; Path=/; expires=Session';
    };

    return (
        <ValidationContainer ref={validWrapper}>
            <div className={styles.mainWrapper}>
                {error && <ClosingAlert type="error" setError={setError} error={error} />}

                <label className={styles.registerLabel}>Вход</label>
                <div className={styles.formContainer}>
                    <div className={styles.question}>
                        <EmailInput onChange={setEmail} />
                    </div>
                    <div className={styles.question}>
                        <PasswordInput onChange={setPassword} />
                    </div>
                    <LoadingButton
                        className={styles.button}
                        sx={GetLoadingButtonStyle('black')}
                        loading={loading}
                        variant="contained"
                        color="success"
                        onClick={handleLogin}
                    >
                        Войти
                    </LoadingButton>
                </div>
                <div>
                    <p>
                        Ещё нет аккаунта? <a href="/home/register">Регистрация</a>
                    </p>
                </div>
            </div>
        </ValidationContainer>
    );
};

function get_cookie(name: string) {
    return document.cookie.split(';').some((c) => {
        return c.trim().startsWith(name + '=');
    });
}

export default Login;
