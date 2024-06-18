import React, { ReactNode } from 'react';
import styles from './Wrappers.scss'

interface MaxWidthWrapperProps {
    children: ReactNode;
}

export const MaxWidthWrapper: React.FC<MaxWidthWrapperProps> = ({ children }) => {
    return (
        <div className={styles.maxWidthWrapper}>
            {children}
        </div>
    );
};