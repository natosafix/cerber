import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import  Login from '../../Components/Registration/Login'
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import {Header} from '../Shared/Header/Header'


onDomContentLoaded(() =>
    ReactDOM.render(
        <CerberThemeProvider>
            <Header/>
            <Login/>
        </CerberThemeProvider>,
        document.getElementById('login'),
    ),
);

