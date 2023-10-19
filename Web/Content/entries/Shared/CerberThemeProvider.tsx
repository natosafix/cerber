import { THEME_2022, ThemeContext, ThemeFactory } from '@skbkontur/react-ui';
import * as React from 'react';
import styles from './CerberThemeProvider.scss';

export const CerberThemeProvider = ({children}) => {
    return (
        <ThemeContext.Provider value={THEME_2022}>
            <div className={styles.pageWrapper}>
                {children}
            </div>
        </ThemeContext.Provider>);
};