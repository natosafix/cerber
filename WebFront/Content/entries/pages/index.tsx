import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Header } from '../Shared/header/header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/domHelpers';


onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
        </CerberThemeProvider>,
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
