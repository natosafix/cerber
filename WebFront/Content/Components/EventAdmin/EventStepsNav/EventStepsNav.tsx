import * as React from 'react';
import styles from './EventStepsNav.scss';
import { Button } from '@skbkontur/react-ui';
import { Box } from '@mui/material';

interface Props<T> {
    step: T;
    setStepNav: (stepNav: T) => void;
    buttons: ButtonInfo<T>[];
    off?: boolean;
}

export class ButtonInfo<T> {
    public matchType: T;
    public content: string;
    public disabled?: boolean;

    constructor(content: string, matchType: T, disabled?: boolean) {
        this.content = content;
        this.matchType = matchType;
        this.disabled = disabled;
    }
}

export const EventStepsNav = <T,>({ step, setStepNav, buttons, off }: Props<T>) => {
    return (
        <Box className={styles.stepsWrapper} sx={{ backgroundColor: off ? 'none' : 'white' }}>
            {!off &&
                buttons.map((info, idx) => (
                    <Button
                        key={idx}
                        active={info.matchType === step}
                        disabled={info.disabled === undefined ? info.matchType > step : info.disabled}
                        size={'medium'}
                        borderless={true}
                        onClick={() => setStepNav(info.matchType)}
                    >
                        {info.content}
                    </Button>
                ))}
        </Box>
    );
};
