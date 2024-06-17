import React from 'react';
import Skeleton from 'react-loading-skeleton';
import 'react-loading-skeleton/dist/skeleton.css';
import styles from './EventPreviewDetails.scss';
import { Gapped } from '@skbkontur/react-ui';

export const EventPreviewDetailsSkeleton = () => {
    return (
        <div className={styles.pageWrapper}>
            <div className={styles.eventWrapper}>
                <Gapped vertical gap={30}>
                    <div className={styles.imgWrapper}>
                        <Skeleton baseColor="#c5c5c5" height={600} style={{ borderRadius: '10px' }} />
                    </div>

                    <div className={styles.contentWrapper}>
                        <Gapped vertical gap={30}>
                            <Gapped vertical gap={10}>
                                <Skeleton width={`80%`} height={30} style={{ marginTop: '10px' }} />
                                <div style={{ opacity: 0.5 }}>
                                    <Skeleton width={`100%`} height={15} style={{ marginTop: '10px' }} />
                                </div>
                            </Gapped>

                            <Gapped vertical gap={8}>
                                <Skeleton width={`100%`} height={15} style={{ marginTop: '20px' }} />
                                <Skeleton width={`100%`} height={15} style={{ marginTop: '5px' }} />
                                <Skeleton width={`100%`} height={15} style={{ marginTop: '5px' }} />
                            </Gapped>
                        </Gapped>
                    </div>
                </Gapped>
            </div>
        </div>
    );
};
