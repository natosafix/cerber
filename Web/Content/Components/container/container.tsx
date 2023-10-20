import * as React from "react";
import styles from "../header/header.scss";
import {PropsWithChildren} from "react";


interface IContainer {
    sku?: number | string;
}

export const Container: React.FC<PropsWithChildren<IContainer>> = ({children}) => {
    return <div className={styles.container}>{children}</div>;
};

