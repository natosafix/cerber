import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import * as ReactDom from 'react-dom';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import * as React from 'react';
import { QuizCongrats } from '../../Components/QuizCongrats/QuizCongrats';

onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            <QuizCongrats />
        </CerberThemeProvider>,
        document.getElementById('quizCongrats'),
    ),
);