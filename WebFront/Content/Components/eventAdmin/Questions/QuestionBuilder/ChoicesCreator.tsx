import React, { useState } from 'react';
import { Button, Gapped, Input } from '@skbkontur/react-ui';
import { Label } from '../../../../Entries/Shared/Label/Label';
import styles from './QuestionBuilder.scss';

interface Props {
    srcChoices: string[];
    setSrcChoices: (string: string[]) => void;
}

export const ChoicesCreator: React.FC<Props> = ({ srcChoices, setSrcChoices }) => {
    const [choices, setChoices] = useState(srcChoices);

    const onRemove = (idx) => {
        let newChoices = choices.filter((c, i) => i !== idx);
        setSrcChoices(newChoices);
        setChoices(newChoices);
    };

    const onAdd = () => {
        let newChoices = [...choices, ''];
        setSrcChoices(newChoices);
        setChoices(newChoices);
    };

    const onValueChange = (value: string, idx: number) => {
        choices[idx] = value;
        setSrcChoices(choices);
        setChoices([...choices]);
    };

    return (
        <Gapped vertical={true}>
            <Label label={'Варинаты ответа'} size={'small'} />
            {choices.map((choice, i) =>
                <div className={styles.lineWrapper}>
                    <div className={styles.inputWrapper}>
                        <Input size={'small'}
                               className={styles.input}
                               value={choice}
                               onValueChange={(v) => onValueChange(v, i)} />
                    </div>
                    <div className={styles.deleteBtnWrapper}>
                        <Button use={'text'} borderless={true} size={'small'} onClick={() => onRemove(i)}>Удалить
                            вариант</Button>
                    </div>
                </div>,
            )}
            <Button use={'default'} onClick={onAdd}>Добавить</Button>
        </Gapped>
    );
};