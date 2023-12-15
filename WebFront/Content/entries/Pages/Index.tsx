import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/eventPreview/eventPreview';
import { EventsProvider } from '../../Components/eventPreview/event-context';


onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            <EventsProvider>
                <EventPreview />
            </EventsProvider>
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
