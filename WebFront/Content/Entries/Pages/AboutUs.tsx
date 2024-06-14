import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { createRoot } from 'react-dom/client';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import * as React from 'react';
import { Error } from '../../Components/Error/Error';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const container = document.getElementById('errorPage');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <Error />
            </Page>,
        );
    }
});
