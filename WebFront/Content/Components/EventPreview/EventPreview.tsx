import React, { useEffect, useState, useRef } from 'react';
import { Events } from './Events';
import { useEvents } from './EventContext';
import styles from './EventPreview.scss';
import { EventCreateButton } from './CreateDraftButton/CreateDraftButton';
import { MaxWidthWrapper } from '../../Entries/Shared/Wrappers/MaxWidthWrapper';
import { Gapped } from '@skbkontur/react-ui';

export const EventPreview = () => {
    const { events, fetchEvents } = useEvents();
    const [loading, setLoading] = useState(true);
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
        <div ref={containerRef}>
            <MaxWidthWrapper>
                <Gapped vertical={true}>
                    <EventCreateButton />

                    <Events loading={loading} events={events} />
                </Gapped>
            </MaxWidthWrapper>
        </div>
    );
};
