import React from 'react';
import styles from './Label.scss';


interface Props {
    size?: "small" | "medium" | "large";
    label: string;
}

export const Label: React.FC<Props> = ({size = "small", label}) => {
    return (
        <>
            {size === "small" && <label className={styles.smallSize}>{label}</label> }
            {size === "medium" && <label className={styles.mediumSize}>{label}</label> }
            {size === "large" && <label className={styles.largeSize}>{label}</label> }
        </>
    );
}