import React, { useEffect, useState } from 'react';
import { Token, TokenInput } from '@skbkontur/react-ui';
import { addInspector, deleteInspector, findUsers, getInspectors } from '../Services/Events';
import { IEvent } from '../Models/IEvent';
import styles from './InspectorEditor.scss';
interface IProps {
    event: IEvent;
}

export const InspectorEditor: React.FC<IProps> = ({ event }) => {
    const [selectedItems, setSelectedItems] = useState<string[]>([]);

    useEffect(() => {
        const fetchInspectors = async () => {
            try {
                let inspectors = await getInspectors(event);
                if (inspectors) setSelectedItems(inspectors);
            } catch (error) {}
        };

        fetchInspectors();
    }, []);

    const getItems = async (username: string) => {
        const users = await findUsers(username);
        if (!users) return [];
        return users;
    };

    return (
        <div className={styles.inspectorEditor}>
            <div>
                <label>Редактирование проверяющих</label>
            </div>
            <div className={styles.editorText}>
                <TokenInput
                    width="100%"
                    placeholder="Введите username инспектора"
                    selectedItems={selectedItems}
                    onValueChange={(itemsNew) => {
                        let newItem = itemsNew.at(itemsNew.length - 1);
                        if (newItem && itemsNew.length > selectedItems.length) addInspector(event, newItem);
                        setSelectedItems(itemsNew);
                    }}
                    getItems={getItems}
                    renderToken={(item, { isActive, onClick, onRemove }) => (
                        <Token
                            key={item.toString()}
                            colors={{ idle: 'defaultIdle', active: 'defaultActive' }}
                            onRemove={(e) => {
                                deleteInspector(event, item);
                                if (onRemove) {
                                    onRemove(e);
                                }
                            }}
                        >
                            {item}
                        </Token>
                    )}
                />
            </div>
        </div>
    );
};
