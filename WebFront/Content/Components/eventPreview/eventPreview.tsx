import React, { useEffect, useState, useRef } from 'react';
import Events from './Events';
import { useEvents } from './event-context';
import styles from './eventPreview.scss';
import { EventCreateButton } from '../../Components/eventPreview/createDraftButton/createDraftButton';

export const EventPreview = () => {
    const { events, fetchEvents } = useEvents();
    const [loading, setLoading] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const containerRef = useRef<HTMLDivElement>(null);

    const handleScroll = () => {
        const container = containerRef.current;
        if (!container || loading) return;

        const { scrollTop, clientHeight, scrollHeight } = container;

        if (scrollTop + clientHeight >= scrollHeight - 20) {
            setLoading(true);
            setCurrentPage((prevPage) => prevPage + 1);
        }
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

    useEffect(() => {
        const container = containerRef.current;
        if (!container) return;

        container.addEventListener('scroll', handleScroll);

        return () => {
            container.removeEventListener('scroll', handleScroll);
        };
    }, [handleScroll]);

    return (
        <div ref={containerRef} className={styles.eventPreviewContainer}>
            <EventCreateButton/>
            <Events events={events} />
            {loading && <p>Loading...</p>}
        </div>
    );
};
