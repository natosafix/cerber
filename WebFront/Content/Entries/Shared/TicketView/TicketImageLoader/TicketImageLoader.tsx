import React, { useEffect, useRef, useState } from 'react';
import styles from './TicketImageLoader.scss';
import { FileUploader, FileUploaderAttachedFile } from '@skbkontur/react-ui';
import { Box } from '@mui/material';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';

interface TicketImageLoaderProps {
    onRemove?: () => void;
    uploader: (file: FileUploaderAttachedFile) => void;
    hideInput?: boolean;
}

function coverExistsValidate(cover: Blob | undefined): Nullable<ValidationInfo> {
    if (!cover) {
        return { message: 'Необходимо загрузить обложку', type: 'submit' };
    }

    return null;
}

export const TicketImageLoader: React.FC<TicketImageLoaderProps> = ({ onRemove, hideInput, uploader }) => {
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
            uploader(files[0]);
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
            {(!hideInput || !preview) &&
                <ValidationWrapper validationInfo={coverExistsValidate(selectedFile)}>
                    <FileUploader accept={'image/*'} onValueChange={onValueChange} />
                </ValidationWrapper>
            }

            {preview && <img src={preview} className={styles.imagePreview} alt={''}></img>}
        </Box>
    );
};
