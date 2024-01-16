import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import Registration from '../../Components/Registration/Registration/Registration'
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import {Header} from '../Shared/Header/Header'


onDomContentLoaded(() =>
    ReactDOM.render(
        <CerberThemeProvider>
            <Header/>
            <Registration/>
        </CerberThemeProvider>,
        document.getElementById('register'),
    ),
);
