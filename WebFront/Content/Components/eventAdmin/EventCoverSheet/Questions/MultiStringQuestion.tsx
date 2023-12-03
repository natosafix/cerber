import styles from '../../EventAdmin.scss';
import variables from '../../EventAdminVariables.scss';
import { Gapped, Textarea } from '@skbkontur/react-ui';
import React, { useEffect, useState } from 'react';
import { Label } from '../../../../Entries/Shared/Label/Label';

interface IMultiStringQuestion {
    storageSaver: ILocalStorageSaver;
    title: string;
}

export const MultiStringQuestion: React.FC<IMultiStringQuestion> = ({ title, storageSaver }) => {
    const [value, setValue] = useState('');

    useEffect(() => {
        let savedValue = storageSaver.load(title);
        if (savedValue && savedValue !== value) {
            setValue(savedValue);
        }
    }, []);

    let saveStorage = () => {
        storageSaver.save(title, value);
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true} className={styles.questionInput}>
            <Label label={title} size={"large"} />
            <Textarea width={'100%'}
                      value={value}
                      onValueChange={setValue}
                      onBlur={saveStorage}
                      maxRows={50}
                      autoResize={true} />
        </Gapped>
    );
};