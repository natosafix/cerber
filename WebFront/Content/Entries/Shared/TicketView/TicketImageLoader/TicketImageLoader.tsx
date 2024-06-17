import React, { useEffect, useRef, useState, useCallback } from 'react';
import styles from './TicketImageLoader.scss';
import { FileUploaderAttachedFile } from '@skbkontur/react-ui';
import { Box } from '@mui/material';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Ticket } from '../Ticket';
import Typography from '@mui/material/Typography';
import { ResizableBox } from 'react-resizable';
import Draggable from 'react-draggable';
import 'react-resizable/css/styles.css';
import { styled } from '@mui/material/styles';
import { useDropzone } from 'react-dropzone';
import ImageIcon from '@mui/icons-material/Image';
import CloseIcon from '@mui/icons-material/Close';

interface TicketImageLoaderProps {
    onRemove?: () => void;
    uploader: (file: FileUploaderAttachedFile) => void;
    hideInput?: boolean;
    ticket: Ticket;
    onSizeUpdater: (qrCodeX?: number, qrCodeY?: number, qrCodeSize?: number) => void;
}

function coverExistsValidate(cover: Blob | undefined): Nullable<ValidationInfo> {
    if (!cover) {
        return { message: 'Необходимо загрузить обложку', type: 'submit' };
    }
    return null;
}

const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: '100%',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: '100%',
});

export const TicketImageLoader: React.FC<TicketImageLoaderProps> = ({
    onRemove,
    hideInput,
    uploader,
    ticket,
    onSizeUpdater,
}) => {
    const [selectedFile, setSelectedFile] = useState<Blob | undefined>(ticket.Cover);
    const [preview, setPreview] = useState<string | null | undefined>();
    const firstRender = useRef(true);
    const [width, setWidth] = useState<number>(ticket.QrCodeSize || 75);
    const [height, setHeight] = useState<number>(ticket.QrCodeSize || 75);
    const [position, setPosition] = useState<{ x: number; y: number }>({
        x: ticket.QrCodeX || 0,
        y: ticket.QrCodeY || 0,
    });

    const handleRemoveImage = () => {
        setSelectedFile(undefined);
        setPreview(undefined);
        onRemove && onRemove();
    };
    const onDrop = useCallback(
        (acceptedFiles: File[]) => {
            if (acceptedFiles.length > 0) {
                const file = acceptedFiles[0];
                setSelectedFile(file);
                uploader({ originalFile: file, status: 'Attached' } as FileUploaderAttachedFile);
            }
        },
        [uploader],
    );

    const { getRootProps, getInputProps } = useDropzone({
        onDrop,
        accept: { 'image/*': ['.jpeg', '.jpg', '.png', '.gif', '.bmp', '.webp'] },
    });

    useEffect(() => {
        if (firstRender.current) {
            firstRender.current = false;
            console.log(position);
            if (ticket.Cover) {
                const objectUrl = URL.createObjectURL(ticket.Cover);
                setPreview(objectUrl);
                return () => URL.revokeObjectURL(objectUrl);
            }
            return;
        }
        if (!selectedFile) {
            setPreview(undefined);
            return;
        }

        const objectUrl = URL.createObjectURL(selectedFile);
        setPreview(objectUrl);
        return () => URL.revokeObjectURL(objectUrl);
    }, [selectedFile]);

    useEffect(() => {}, [preview]);

    const onResize = (event: any, { size }: { size: { width: number; height: number } }) => {
        console.log(event);
        const newSize = event.movementX === 0 ? event.movementY : event.movementX;
        if (width + newSize > 150 || width + newSize < 50) return;
        setWidth(width + newSize);
        setHeight(height + newSize);
    };

    useEffect(() => {
        const handleChange = () => {
            onSizeUpdater(position.x, position.y, width);
        };
        handleChange();
    }, [width, position, onSizeUpdater]);

    const handleDrag = (e: any, ui: any) => {
        const { x, y } = position;
        setPosition({ x: x + ui.deltaX, y: y + ui.deltaY });
    };

    const handleStop = (e: any, data: any) => {
        setPosition({ x: data.x, y: data.y });
    };

    return (
        <Box sx={{ position: 'relative', width: '100%', height: '100%' }} className={styles.iconHoverContainer}>
            {preview == undefined && (
                <ValidationWrapper validationInfo={coverExistsValidate(selectedFile)}>
                    <Box
                        {...getRootProps()}
                        sx={{
                            textAlign: 'center',
                            width: '592px',
                            height: '200px',
                            cursor: 'pointer',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                        }}
                    >
                        <input {...getInputProps()} className={styles.visuallyHiddenInput} />
                        <Box
                            sx={{
                                display: 'flex',
                                flexDirection: 'column',
                                alignItems: 'center',
                                justifyContent: 'center',
                                gap: '10px',
                            }}
                        >
                            <ImageIcon fontSize="large" className={styles.iconHoverEffect} />
                            <Typography className={styles.iconHoverEffect}>{'600x200'}</Typography>
                        </Box>
                    </Box>
                </ValidationWrapper>
            )}

            {preview && (
                <Box sx={{ position: 'relative', display: 'inline-block', width: '100%', height: '100%' }}>
                    <img src={preview} className={styles.imagePreview} alt="Preview" />
                    <CloseIcon
                        sx={{
                            position: 'absolute',
                            top: '8px',
                            right: '8px',
                            cursor: 'pointer',
                            backgroundColor: 'white',
                            borderRadius: '50%',
                        }}
                        onClick={handleRemoveImage}
                    />

                    <Draggable
                        bounds="parent"
                        cancel=".react-resizable-handle"
                        defaultPosition={position}
                        onDrag={handleDrag}
                        onStop={handleStop}
                    >
                        <ResizableBox
                            width={width}
                            height={height}
                            minConstraints={[75, 75]}
                            maxConstraints={[150, 150]}
                            resizeHandles={['se']}
                            onResize={onResize}
                            className={styles.resizableBox}
                            style={{ borderRadius: '10px' }}
                        >
                            <Box
                                sx={{
                                    display: 'flex',
                                    justifyContent: 'center',
                                    alignItems: 'center',
                                    backgroundColor: 'white',
                                    width: '100%',
                                    height: '100%',
                                    position: 'relative',
                                    cursor: 'pointer',
                                    borderRadius: '10px',
                                }}
                            >
                                <Typography sx={{ lineHeight: 'normal' }} id="outlined-disabled">
                                    QR-код
                                </Typography>
                            </Box>
                        </ResizableBox>
                    </Draggable>
                </Box>
            )}
        </Box>
    );
};
