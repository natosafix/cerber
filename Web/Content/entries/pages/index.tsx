import * as React from 'react';
import * as ReactDom from 'react-dom';
import { onDomContentLoaded } from '../../Components/utils/domHelpers';
import { Header } from '../../Components/header/header';
import { createRoot } from 'react-dom/client';

onDomContentLoaded(() =>
    ReactDom.render(
        <>
            <Header />
            Hello, World!!
        </>,
        document.getElementById('index'),
    ),
);

// let place = document.getElementById('index');
// let root = createRoot(place!);
// root.render(
//     <>
//         <Header />
//         Hello, World!!
//     </>,
// );
