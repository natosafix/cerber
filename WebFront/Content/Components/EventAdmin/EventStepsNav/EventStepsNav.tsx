import * as React from 'react';
import styles from '../EventAdmin.scss';
import { Button } from '@skbkontur/react-ui';
import { EventAdminPageNav } from './EventAdminPageNav';

interface Props {
    step: EventAdminPageNav;
    setStepNav: (stepNav: EventAdminPageNav) => void;
}

class ButtonInfo {
    public matchType: EventAdminPageNav;
    public content: string;

    constructor(content: string, matchType: EventAdminPageNav) {
        this.content = content;
        this.matchType = matchType;
    }
}

export const EventStepsNav: React.FC<Props> = ({ step, setStepNav }) => {
    const buttonsInfo = [
        new ButtonInfo('Описание события', EventAdminPageNav.EventCoverSheet),
        new ButtonInfo('Анкета регистрации', EventAdminPageNav.EventQuizCreator),
        new ButtonInfo('Билеты', EventAdminPageNav.EventTickets),
        new ButtonInfo('Публикация', EventAdminPageNav.EventPublish),
    ];

    return (
        <div className={styles.stepsWrapper}>
            {buttonsInfo.map((info, idx) => (
                <Button
                    key={idx}
                    active={info.matchType === step}
                    disabled={info.matchType > step}
                    size={'medium'}
                    borderless={true}
                    onClick={() => setStepNav(info.matchType)}
                >
                    {info.content}
                </Button>
            ))}
        </div>
    );
};
