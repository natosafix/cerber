import * as React from 'react';
import { Group, Button, Textarea } from '@skbkontur/react-ui';

import styles from './header.scss';

export const Header: React.FC = () => {
    // return <div className={styles.headerWrapper}>I'm a Header</div>;
    const [value, setValue] = React.useState('Значение');
    
    return <Group>
        <Textarea
            value={value}
            onValueChange={setValue}
            autoResize
            rows={1}
            placeholder="Плейсхолдер"
        />
        <Button style={{ height: '52px' }} onClick={() => setValue('')}>Очистить значение</Button>
    </Group>
};
