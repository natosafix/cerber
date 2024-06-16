import React, { ReactNode } from 'react';
import styles from './TicketForm.scss';
import { Box } from '@mui/material';

interface RectangleProps {
    backgroundColor: string;
    borderColor: string;
    borderWidth: number;
    polygon: string;
    height: number;
    width: number;
    margin?: string;
    children?: ReactNode;
}

const Rectangle: React.FC<RectangleProps> = ({
    backgroundColor,
    borderColor,
    borderWidth,
    polygon,
    height,
    width,
    margin,
    children,
}) => {
    return (
        <Box className={styles.container}>
            <Box
                sx={{
                    width: `${width}`,
                    height: `${height}`,
                    position: 'relative',
                    backgroundColor: `${borderColor}`,
                    clipPath: `polygon(${polygon})`,
                    margin: `${margin}`,
                }}
            >
                <Box
                    sx={{
                        position: 'absolute',
                        top: `${borderWidth}px`,
                        left: `${borderWidth}px`,
                        width: `${width - 2 * borderWidth}px`,
                        height: `${height - 2 * borderWidth}px`,
                        background: backgroundColor,
                        clipPath: `polygon(${polygon})`,
                    }}
                >
                    {children}
                </Box>
            </Box>
        </Box>
    );
};

export default Rectangle;
