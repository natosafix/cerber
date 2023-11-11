import { onDomContentLoaded } from '../../Components/utils/domHelpers';
import * as ReactDom from 'react-dom';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../../Components/header/header';
import * as React from 'react';
import { EventAdmin } from '../../Components/eventAdmin/eventAdmin';

onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            <EventAdmin />
        </CerberThemeProvider>,
        document.getElementById('eventAdmin'),
    ),
);