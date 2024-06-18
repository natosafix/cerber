import React, { useState, useEffect } from 'react';
import { Alert } from '@mui/material';

export const ClosingAlert = ({ error, setError, type }) => {
    const handleClose = () => {
        setError(null);
    };

    useEffect(() => {
        const timer = setTimeout(() => {
            if (error) {
                setError(null);
            }
        }, 2000);

        return () => clearTimeout(timer);
    }, [error]);

    return (
        <>
            {error && (
                <Alert
                    sx={{
                        position: 'absolute',
                        top: '150px',
                        right: '0',
                        marginRight: '-50px',
                        transform: 'translate(-50%, -50%)',
                        zIndex: 9999,
                    }}
                    draggable
                    onClose={handleClose}
                    severity={type}
                >
                    {error.toString()}
                </Alert>
            )}
        </>
    );
};
