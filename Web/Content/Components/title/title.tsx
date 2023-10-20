import * as React from "react";
import styles from "../header/header.scss";
import {PropsWithChildren} from "react";


export const Title: React.FC<PropsWithChildren> = ({children}) => {
    return <p className={styles.title}>{children}</p>;
};
