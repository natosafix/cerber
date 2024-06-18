import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import Login from '../../Components/Registration/Login';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const container = document.getElementById('login');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <Login />
            </Page>,
        );
    }
});
