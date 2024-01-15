import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import  Authorization from '../../Components/Registration/Authorization'


onDomContentLoaded(() =>
    ReactDOM.render(
       <Authorization/>,
        document.getElementById('register'),
    ),
);
