import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import  Login from '../../Components/Registration/Login'


onDomContentLoaded(() =>
    ReactDOM.render(
       <Login/>,
        document.getElementById('login'),
    ),
);

