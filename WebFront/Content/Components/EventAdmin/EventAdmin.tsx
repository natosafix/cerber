import * as React from 'react';
import {useState} from 'react';
import styles from './EventAdmin.scss';
import {EventStepsNav} from './EventStepsNav/EventStepsNav';
import {EventCoverSheet} from './EventCoverSheet/EventCoverSheet';
import {EventAdminPageNav} from './EventStepsNav/EventAdminPageNav';
import {EventQuizCreator} from './EventQuizCreator/EventQuizCreator';
import {EventPublish} from './EventPublish/EventPublish';
import {Gapped} from '@skbkontur/react-ui';
import { EventAdminClient } from '../../../Api/EventAdmin/EventAdminClient';


export const EventAdmin: React.FC = () => {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const myParam = urlParams.get('id')!;

    const [draftId, setDraftId] = useState<string>(myParam);
    const [step, setStep] = useState(EventAdminPageNav.EventCoverSheet);

    const onSave = async () => {
        if (step === EventAdminPageNav.EventPublish) {
            EventAdminClient.publishDraft().then(r => {
                alert(JSON.stringify(r));
            });
        } else {
            // alert('Save current page');
            setStep(step + 1);
        }
    };

    return (
        <div className={styles.mainWrapper}>
            <EventStepsNav step={step} setStepNav={setStep}/>

            <div className={styles.contentPageWrapper}>
                <div className={styles.contentWrapper}>
                    <Gapped gap={30} vertical={true}>
                        {step === EventAdminPageNav.EventCoverSheet && (
                            <EventCoverSheet onSave={onSave}/>
                        )}
                        {step === EventAdminPageNav.EventQuizCreator && (
                            <EventQuizCreator onSave={onSave}/>
                        )}
                        {step === EventAdminPageNav.EventPublish && (
                            <EventPublish onSave={onSave}/>
                        )}
                    </Gapped>
                </div>
            </div>
        </div>);
};