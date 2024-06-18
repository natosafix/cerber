import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { createRoot } from 'react-dom/client';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { Header } from '../Shared/Header/Header';
import * as React from 'react';
import { QuizCongrats } from '../../Components/QuizCongrats/QuizCongrats';
import { QuizSolve } from '../../Components/QuizSolve/QuizSolve';
import { Page } from '../Page';

onDomContentLoaded(() => {
    const container = document.getElementById('quizSolve');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <QuizSolve />
            </Page>,
        );
    }
});
