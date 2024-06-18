import React, { useEffect, useState, useRef } from 'react';
import { Events } from './Events';
import { useEvents } from './EventContext';
import styles from './EventPreview.scss';
import { EventCreateButton } from './CreateDraftButton/CreateDraftButton';
import { MaxWidthWrapper } from '../../Entries/Shared/Wrappers/MaxWidthWrapper';
import { Gapped } from '@skbkontur/react-ui';
import { Box } from '@mui/material';
import AddCircleOutlineIcon from '@mui/icons-material/AddCircleOutline';
import LoadingButton from '@mui/lab/LoadingButton';

interface EventPreviewProps {
    isPrivate: boolean;
}

export const EventPreview: React.FC<EventPreviewProps> = ({ isPrivate }) => {
    const { events, fetchEvents, haveMore } = useEvents(isPrivate);
    const [loading, setLoading] = useState(true);
    const [currentPage, setCurrentPage] = useState(1);
    const containerRef = useRef<HTMLDivElement>(null);
    const handleClickUploadButton = async () => {
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

    return (
        <div ref={containerRef}>
            <MaxWidthWrapper>
                <Gapped vertical={true}>
                    <EventCreateButton />

                    <Events loading={loading} events={events} />
                    <Box className={styles.loadMoreButton}>
                        {haveMore && (
                            <LoadingButton
                                loading={loading}
                                sx={{
                                    color: '#7c7c7c',
                                    borderColor: '#7c7c7c',
                                    '&:hover': {
                                        backgroundColor: 'rgb(124,124,124, 0.1)',
                                        borderColor: '#7c7c7c',
                                    },
                                }}
                                variant="outlined"
                                startIcon={<AddCircleOutlineIcon />}
                                onClick={handleClickUploadButton}
                            >
                                {'Показать ещё'}
                            </LoadingButton>
                        )}
                    </Box>
                </Gapped>
            </MaxWidthWrapper>
        </div>
    );
};
