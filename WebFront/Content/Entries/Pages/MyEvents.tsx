import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/EventPreview/EventPreview';
import { EventsProvider } from '../../Components/EventPreview/EventContext';
import { SkeletonTheme } from 'react-loading-skeleton';
import { Error } from '../../Components/Error/Error';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const container = document.getElementById('myEvents');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <SkeletonTheme baseColor="#f2f2f2" highlightColor="#b3b3b3">
                    <EventsProvider>
                        <EventPreview isPrivate={true} />
                    </EventsProvider>
                </SkeletonTheme>
            </Page>,
        );
    }
});
