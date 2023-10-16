import * as React from 'react';
import * as ReactDom from 'react-dom';
import { onDomContentLoaded } from '../../Components/utils/domHelpers';
import { Header } from '../../Components/header/header';

onDomContentLoaded(() =>
    ReactDom.render(
        <>
            <Header />
            Hello, World!!
        </>,
        document.getElementById('index'),
    ),
);
