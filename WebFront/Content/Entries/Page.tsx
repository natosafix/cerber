import React, { ReactNode } from 'react';
import { CerberThemeProvider } from './Shared/ThemeProvider/CerberThemeProvider';
import { Header } from './Shared/Header/Header';

interface PageProps {
    children: ReactNode;
}

export const Page: React.FC<PageProps> = ({ children }) => {
    return (
        <CerberThemeProvider>
            <Header />
            {children}
        </CerberThemeProvider>
    );
};
