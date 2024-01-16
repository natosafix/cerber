import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import * as ReactDOM from 'react-dom';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import * as React from 'react';
import { Error } from '../../Components/Error/Error';

onDomContentLoaded(() =>
    ReactDOM.render(
        <CerberThemeProvider>
            <Header />
            <Error />
        </CerberThemeProvider>
        ,
        document.getElementById('errorPage'),
    ),
);