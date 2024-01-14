// index.jsx
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Header } from '../Shared/Header/Header';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { EventPreview } from '../../Components/eventPreview/eventPreview';
import { EventsProvider } from '../../Components/eventPreview/event-context';
import { EventDetails } from '../../Components/eventPreview/event-details/eventDetails';
import { EventAdmin } from '../../Components/EventAdmin/EventAdmin';


onDomContentLoaded(() =>
    ReactDOM.render(
        <Router>
            <CerberThemeProvider>
                <Header />
                <EventsProvider>
                    <Routes>
                        <Route path="/home/index" element={<EventPreview />} />
                        <Route path="/home/preview/:id" element={<EventDetails />} />
                    </Routes>
                </EventsProvider>
                <Routes>
                    <Route path="eventAdmin/draft" element={<EventAdmin/>}/>
                </Routes>
            </CerberThemeProvider>
        </Router>,
        document.getElementById('index'),
    ),
);
