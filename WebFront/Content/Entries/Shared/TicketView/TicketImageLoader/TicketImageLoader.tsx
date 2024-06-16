import React, { useEffect, useRef, useState } from 'react';
import styles from './TicketImageLoader.scss';
import { FileUploader, FileUploaderAttachedFile } from '@skbkontur/react-ui';
import { Box } from '@mui/material';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Ticket } from '../Ticket';
import Typography from '@mui/material/Typography';
import { ResizableBox } from 'react-resizable';
import Draggable from 'react-draggable';
import 'react-resizable/css/styles.css';

interface TicketImageLoaderProps {
    onRemove?: () => void;
    uploader: (file: FileUploaderAttachedFile) => void;
    hideInput?: boolean;
    ticket: Ticket;
}

function coverExistsValidate(cover: Blob | undefined): Nullable<ValidationInfo> {
    if (!cover) {
        return { message: 'Необходимо загрузить обложку', type: 'submit' };
    }
    return null;
}

export const TicketImageLoader: React.FC<TicketImageLoaderProps> = ({ onRemove, hideInput, uploader, ticket }) => {
    const [selectedFile, setSelectedFile] = useState<Blob | undefined>(ticket.Cover);
    const [preview, setPreview] = useState<string | null | undefined>();
    const firstRender = useRef(true);
    const [width, setWidth] = useState<number>(50);
    const [height, setHeight] = useState<number>(50);
    const [position, setPosition] = useState<{ x: number; y: number }>({ x: 0, y: 0 });

    const onValueChange = (files: FileUploaderAttachedFile[]) => {
        if (files.length === 0) {
            onRemove && onRemove();
            setSelectedFile(undefined);
            return;
        }
        if (files[0].status === 'Uploaded' || files[0].status === 'Attached') {
            setSelectedFile(files[0].originalFile);
            uploader(files[0]);
        }
    };

    useEffect(() => {
        if (firstRender.current) {
            firstRender.current = false;
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

    useEffect(() => {
        console.log([preview]);
        console.log(firstRender.current);
    }, [preview]);

    const onResize = (event: any, { size }: { size: { width: number; height: number } }) => {
        console.log(event);
        const newSize = event.movementX === 0 ? event.movementY : event.movementX;
        if (width + newSize > 150 || width + newSize < 50) return;
        setWidth(width + newSize);
        setHeight(height + newSize);
    };

    const handleDrag = (e: any, ui: any) => {
        const { x, y } = position;
        setPosition({ x: x + ui.deltaX, y: y + ui.deltaY });
    };

    const handleStop = (e: any, data: any) => {
        setPosition({ x: data.x, y: data.y });
    };

    return (
        <Box sx={{ position: 'relative', width: '100%', height: '100%' }}>
            {(!hideInput || !preview) && (
                <ValidationWrapper validationInfo={coverExistsValidate(selectedFile)}>
                    <FileUploader accept={'image/*'} onValueChange={onValueChange} />
                </ValidationWrapper>
            )}
            {preview && (
                <Box sx={{ position: 'relative', display: 'inline-block', width: '100%', height: '100%' }}>
                    <img src={preview} className={styles.imagePreview} alt={''} />
                    <Draggable
                        bounds="parent"
                        cancel=".react-resizable-handle"
                        defaultPosition={{ x: 0, y: 0 }}
                        onDrag={handleDrag}
                        onStop={handleStop}
                    >
                        <ResizableBox
                            width={width}
                            height={height}
                            minConstraints={[50, 50]}
                            maxConstraints={[150, 150]}
                            resizeHandles={['se']}
                            onResize={onResize}
                            className={styles.resizableBox}
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
