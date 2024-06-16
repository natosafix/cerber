import React, { useEffect, useRef, useState } from 'react';
import styles from './TicketImageLoader.scss';
import { FileUploader, FileUploaderAttachedFile } from '@skbkontur/react-ui';
import { Box } from '@mui/material';

interface TicketImageLoaderProps {
    onRemove?: () => void;
    hideInput?: boolean;
}

export const TicketImageLoader: React.FC<TicketImageLoaderProps> = ({ onRemove, hideInput }) => {
    const [selectedFile, setSelectedFile] = useState<Blob | undefined>();
    const [preview, setPreview] = useState<string | null | undefined>();
    let firstRender = useRef(true);

    const onValueChange = (files: FileUploaderAttachedFile[]) => {
        if (files.length === 0) {
            onRemove && onRemove();
            setSelectedFile(undefined);
            return;
        }
        if (files[0].status === 'Uploaded' || files[0].status === 'Attached') {
            setSelectedFile(files[0].originalFile);
        }
    };

    useEffect(() => {
        if (firstRender.current) {
            firstRender.current = false;
            return;
        }
        if (!selectedFile) {
            setPreview(undefined);
            return;
        }

        let objectUrl = URL.createObjectURL(selectedFile);
        setPreview(objectUrl);
        return () => URL.revokeObjectURL(objectUrl);
    }, [selectedFile]);

    return (
        <Box>
            {(!hideInput || !preview) && <FileUploader accept={'image/*'} onValueChange={onValueChange} />}

            {preview && <img src={preview} className={styles.imagePreview} alt={''}></img>}
        </Box>
    );
};
