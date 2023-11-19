import * as ReactDom from 'react-dom';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import * as React from 'react';
import { EventAdmin } from '../../Components/eventAdmin/eventAdmin';
import { Header } from '../Shared/header/header';
import { onDomContentLoaded } from '../../Helpers/domHelpers';

onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            <EventAdmin />
        </CerberThemeProvider>,
        document.getElementById('eventAdmin'),
    ),
);