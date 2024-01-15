import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/eventPreview/eventPreview';
import { EventsProvider } from '../../Components/eventPreview/event-context';
import { EventDetails } from '../../Components/eventPreview/event-details/eventDetails';

onDomContentLoaded(() => {
    const id = window.location.pathname.split('/').pop();

    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            <EventsProvider>
                <EventDetails id={id} />
            </EventsProvider>
        </CerberThemeProvider>,
        document.getElementById('preview'),
    );
});
