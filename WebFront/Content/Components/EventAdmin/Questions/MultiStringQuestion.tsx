import styles from '../EventAdmin.scss';
import variables from '../EventAdminVariables.scss';
import {Gapped, Textarea} from '@skbkontur/react-ui';
import React, {useEffect, useState} from 'react';
import {Label} from '../../../Entries/Shared/Label/Label';

interface IMultiStringQuestion {
    title: string;
    size?: "small" | "medium" | "large";
    onValueChange?: (value: string) => void;
    defaultValue?: string;
}

export const MultiStringQuestion: React.FC<IMultiStringQuestion> = (
    {
        title,
        size = "large",
        onValueChange = null,
        defaultValue = ''
    }) => {
    const [value, setValue] = useState(defaultValue);

    const changeValue = (v: string) => {
        setValue(v);
        if (onValueChange) {
            onValueChange(v);
        }
    }

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true} className={styles.questionInput}>
            <Label label={title} size={size}/>
            <Textarea width={'100%'}
                      value={value}
                      onValueChange={changeValue}
                      maxRows={50}
                      autoResize={true}/>
        </Gapped>
    );
};