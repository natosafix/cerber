import React, { useEffect, useState, useRef } from 'react';
import { Events } from './Events';
import { useEvents } from './EventContext';
import styles from './EventPreview.scss';
import { EventCreateButton } from './CreateDraftButton/CreateDraftButton';
import { MaxWidthWrapper } from '../../Entries/Shared/Wrappers/MaxWidthWrapper';
import { Gapped } from '@skbkontur/react-ui';
import { Button } from '@skbkontur/react-ui';
import event from './Event/Event';

export const EventPreview = () => {
    const { events, fetchEvents } = useEvents();
    const [loading, setLoading] = useState(true);
    const [currentPage, setCurrentPage] = useState(1);
    const containerRef = useRef<HTMLDivElement>(null);

    const handleClickUploadButton = async () => {
        if (events.length % 6 !== 0) {
            return;
        }
        setLoading(true);
        setCurrentPage((prevPage) => prevPage + 1);
    };

    useEffect(() => {
        const loadMoreEvents = async () => {
            try {
                await fetchEvents(events.length);
            } finally {
                setLoading(false);
            }
        };

        loadMoreEvents();
    }, [fetchEvents, currentPage]);

    // useEffect(() => {
    //     const container = containerRef.current;
    //     if (!container) return;
    //
    //     container.addEventListener('scroll', handleScroll);
    //
    //     return () => {
    //         container.removeEventListener('scroll', handleScroll);
    //     };
    // }, [handleScroll]);

    return (
        <div ref={containerRef}>
            <MaxWidthWrapper>
                <Gapped vertical={true}>
                    <EventCreateButton />

                    <Events loading={loading} events={events} />
                    {events.length % 6 === 0 && <Button onClick={handleClickUploadButton}>{'Показать ещё'}</Button>}
                    <div className={styles.bottomDev} />
                </Gapped>
            </MaxWidthWrapper>
        </div>
    );
};
