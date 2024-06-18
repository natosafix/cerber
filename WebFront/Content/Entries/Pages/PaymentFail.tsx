import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { CerberThemeProvider } from '../Shared/ThemeProvider/CerberThemeProvider';
import { EventAdmin } from '../../Components/EventAdmin/EventAdmin';
import { Header } from '../Shared/Header/Header';
import { onDomContentLoaded } from '../../Helpers/DomHelpers';
import { Error } from '../../Components/Error/Error';
import { Page } from '../Page';
import { PaymentFail } from '../../Components/Payment/PaymentFail/PaymentFail';

onDomContentLoaded(() => {
    const container = document.getElementById('paymentFailed');
    if (container) {
        const root = createRoot(container);
        root.render(
            <Page>
                <PaymentFail />
            </Page>,
        );
    }
});
