import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import * as ReactDom from 'react-dom';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import * as React from 'react';
import { QuizSolve } from '../../Components/QuizSolve/QuizSolve';

onDomContentLoaded(() =>
    ReactDom.render(
        <CerberThemeProvider>
            <Header />
            <QuizSolve />
        </CerberThemeProvider>,
        document.getElementById('quizSolve'),
    ),
);