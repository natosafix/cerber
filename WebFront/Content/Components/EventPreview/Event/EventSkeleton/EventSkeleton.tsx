import React from 'react';
import Skeleton from 'react-loading-skeleton';
import 'react-loading-skeleton/dist/skeleton.css';
import styles from './EventSkeleton.scss';

export const CardSkeleton = ({ cards }) => {
    return Array(cards)
        .fill(0)
        .map((_, i) => (
            <div className={styles.eventWrapper} key={i}>
                <div className={styles.imgWrapper}>
                    <Skeleton height={240} style={{ borderRadius: '10px' }} />
                </div>
                <div className={styles.textWrapper}>
                    <div className={styles.titleWrapper}>
                        <Skeleton width={`80%`} height={20} />
                    </div>
                    <Skeleton width={`60%`} height={15} style={{ marginTop: '10px' }} />
                    <Skeleton width={`50%`} height={15} style={{ marginTop: '5px' }} />
                </div>
            </div>
        ));
};
