// index.jsx
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/eventPreview/eventPreview';
import { EventsProvider } from '../../Components/eventPreview/event-context';


onDomContentLoaded(() =>
    ReactDOM.render(
            <CerberThemeProvider>
                <Header />
                <EventsProvider>
                        <EventPreview />
                </EventsProvider>
            </CerberThemeProvider>
        ,
        document.getElementById('index'),
    ),
);
