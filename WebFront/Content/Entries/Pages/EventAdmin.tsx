import * as ReactDom from 'react-dom';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import * as React from 'react';
import { EventAdmin } from '../../Components/EventAdmin/EventAdmin';
import { Header } from '../Shared/Header/Header';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';

onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            
            <EventAdmin />
        </CerberThemeProvider>,
        document.getElementById('eventAdmin'),
    ),
);