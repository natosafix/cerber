import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import Registration from '../../Components/Registration/Registration/Registration';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const container = document.getElementById('register');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <Registration />
            </Page>,
        );
    }
});
