import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { EventAdmin } from '../../Components/EventAdmin/EventAdmin';
import { Header } from '../Shared/Header/Header';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { Error } from '../../Components/Error/Error';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const container = document.getElementById('eventAdmin');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <EventAdmin />
            </Page>,
        );
    }
});
