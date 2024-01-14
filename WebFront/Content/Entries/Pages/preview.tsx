import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/eventPreview/eventPreview';
import { EventsProvider } from '../../Components/eventPreview/event-context';
import {BrowserRouter as Router, Route, Routes} from "react-router-dom";
import { EventDetails } from '../../Components/eventPreview/event-details/eventDetails';


onDomContentLoaded(() =>
    ReactDom.render(
        <Router>
            <CerberThemeProvider>
                <Header />
                <EventsProvider>
                    <Routes>
                        <Route path="/home/index" element={<EventPreview />} />
                        <Route path="/home/preview/:id" element={<EventDetails />} />
                    </Routes>
                </EventsProvider>
            </CerberThemeProvider>
        </Router>,
        document.getElementById('preview'),
    ),
);
