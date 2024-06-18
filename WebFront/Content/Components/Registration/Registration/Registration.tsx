import React, { useState, useRef } from 'react';
import { EmailInput } from '../Inputs/EmailInput';
import { PasswordInput } from '../Inputs/PasswordInput';
import { UsernameInput } from '../Inputs/UsernameInput';
import { ValidationContainer } from '@skbkontur/react-ui-validations';
import { register } from '../../EventPreview/Services/Events';
import styles from './Registration.scss';
import { GetLoadingButtonStyle, Route } from '../../../Utility/Constants';
import LoadingButton from '@mui/lab/LoadingButton';
import { ClosingAlert } from '../../../Entries/Shared/Alert/ClosingAlert';

const Registration = () => {
    const [username, setUsername] = useState('');
    const [email, setEmail] = useState('');
    const [error, setError] = useState();
    const [password, setPassword] = useState('');
    const validWrapper = useRef<ValidationContainer>(null);
    const [loading, setLoading] = useState<boolean>(false);
    if (get_cookie('CerberAuth')) {
        window.location.href = Route.INDEX;
    }
    const handleRegister = async () => {
        try {
            if (validWrapper.current) {
                const isValid = await validWrapper.current.validate();
                if (isValid) {
                    setLoading(true);
                    const result = await register({ username, email, password });
                    if (!result.success) {
                        setError(result.data);
                        setLoading(false);
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
                    {error && <ClosingAlert type="error" setError={setError} error={error} />}

                    <label className={styles.registerLabel}>Регистрация</label>
                    <div className={styles.formContainer}>
                        <div className={styles.question}>
                            <EmailInput onChange={setEmail} />
                        </div>
                        <div className={styles.question}>
                            <UsernameInput onChange={setUsername} />
                        </div>
                        <div className={styles.question}>
                            <PasswordInput onChange={setPassword} />
                        </div>
                        <LoadingButton
                            className={styles.button}
                            loading={loading}
                            sx={GetLoadingButtonStyle('black')}
                            variant="contained"
                            color="success"
                            onClick={handleRegister}
                        >
                            Зарегистрироваться
                        </LoadingButton>
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
