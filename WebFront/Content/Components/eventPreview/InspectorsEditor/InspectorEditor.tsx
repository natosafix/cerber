import React from "react";
import {Token, TokenInput} from "@skbkontur/react-ui";
import {findUsers} from "../services/events";
const delay = ms => v => new Promise(resolve => setTimeout(resolve, ms, v));

export const InspectorEditor: React.FC = () => {
    const getItems = async (username: string) => {
         const users = await findUsers(username);
         if (!users)
             return [];
         return users;
    }
    
    return (
        <div>
            <div>
                <label>
                    <span>Добавить инспектора</span>
                </label>
            </div>
            <div className="ainspectorEditor-field">
                <TokenInput
                    className="inspectorEditor-tokenInput"
                    width="100%"
                    placeholder="Введите username инспектора"
                    getItems={getItems}
                    renderToken={(item, { isActive, onClick, onRemove }) => (
                        <Token
                            key={item.toString()}
                            colors={{ idle: "defaultIdle", active: "defaultActive" }}
                            isActive={isActive}
                            onClick={onClick}
                            onRemove={onRemove}
                            onValueChange={}
                        >
                            {item}
                        </Token>
                    )}
                />
            </div>

        </div>
    )
}