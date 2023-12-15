import React from 'react';
import img from '../../../Images/bin.png'
import styles from './BinButton.scss'

interface Props {
    onClick: () => void;
}

export const BinButton: React.FC<Props> = ({onClick}) => {
    return (
        <button className={styles.binBtn} onClick={onClick}>
            <img className={styles.binImg} src={img} alt="remove" />
        </button>
    );
}