import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/EventPreview/EventPreview';
import { EventsProvider } from '../../Components/EventPreview/EventContext';
import { EventDetails } from '../../Components/EventPreview/EventDetails/EventDetails';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const id = window.location.pathname.split('/').pop();
    const container = document.getElementById('preview');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <EventsProvider>
                    <EventDetails id={id} />
                </EventsProvider>
            </Page>,
        );
    }
});
