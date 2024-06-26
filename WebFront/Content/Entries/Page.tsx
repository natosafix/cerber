import React, { ReactNode } from 'react';
import { CerberThemeProvider } from './Shared/ThemeProvider/CerberThemeProvider';
import { Header } from './Shared/Header/Header';
import Footer from './Shared/Footer/Footer';
import { Box } from '@mui/material';
import { ClosingAlert } from './Shared/Alert/ClosingAlert';

interface PageProps {
    children: ReactNode;
}

export const Page: React.FC<PageProps> = ({ children }) => {
    return (
        <CerberThemeProvider>
            <Box sx={{ minHeight: 'calc(100vh - 150px)' }}>
                <Header />
                {children}
            </Box>
            <Footer />
        </CerberThemeProvider>
    );
};
