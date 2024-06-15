import React, { useState, useRef } from 'react';
import { EmailInput } from '../Inputs/EmailInput';
import { PasswordInput } from '../Inputs/PasswordInput';
import { UsernameInput } from '../Inputs/UsernameInput';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { register } from '../../EventPreview/Services/Events';
import styles from './Registration.scss';
import { Route } from '../../../Utility/Constants';

const Registration = () => {
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [error, setError] = useState();
    const [password, setPassword] = useState('');
    const validWrapper = useRef<ValidationContainer>(null);

    if (get_cookie('CerberAuth')) {
        window.location.href = Route.INDEX;
    }
    const handleRegister = async () => {
        try {
            if (validWrapper.current) {
                const isValid = await validWrapper.current.validate();
                if (isValid) {
                    const result = await register({ username, email, password });
                    if (!result.success) {
                        setError(result.data);
                    } else {
                        window.location.href = Route.LOGIN;
                    }
                }
            }
        } catch (error) {}
    };

    return (
        <div className={styles.pageWrapper}>
            <ValidationContainer ref={validWrapper}>
                <div className={styles.mainWrapper}>
                    {error && <label className={styles.errorLabel}>{error}</label>}
                    <label className={styles.registerLabel}>Регистрация</label>
                    <div className={styles.formContainer}>
                        <div className={styles.question}>
                            <EmailInput onChange={setEmail} />
                        </div>
                        <div className={styles.question}>
                            <PasswordInput onChange={setPassword} />
                        </div>
                        <div className={styles.question}>
                            <UsernameInput onChange={setUsername} />
                        </div>
                        <button onClick={handleRegister}>Зарегистрироваться</button>
                    </div>
                    <div>
                        <p>
                            Уже зарегистрированы? <a href="/home/login">Войти</a>
                        </p>
                    </div>
                </div>
            </ValidationContainer>
        </div>
    );
};

function get_cookie(name: string) {
    return document.cookie.split(';').some((c) => {
        return c.trim().startsWith(name + '=');
    });
}

export default Registration;
