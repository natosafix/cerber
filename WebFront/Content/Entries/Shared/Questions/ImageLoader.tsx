import React, { useEffect, useRef, useState } from 'react';
import styles from './QuestionStyles.scss';
import variables from './QuestionVariables.scss';
import { FileUploader, FileUploaderAttachedFile, Gapped } from '@skbkontur/react-ui';
import { Label } from '../Label/Label';

interface IImageLoaderQuestion {
    title?: string;
    defaultUrl?: string | null | undefined;
    uploader?: (file: FileUploaderAttachedFile) => Promise<void>;
    onRemove?: () => void;
    hideInput?: boolean;
}

export const ImageLoader: React.FC<IImageLoaderQuestion> = ({ title, defaultUrl, uploader, onRemove, hideInput }) => {
    const [selectedFile, setSelectedFile] = useState<Blob | undefined>();
    const [preview, setPreview] = useState<string | null | undefined>(defaultUrl);
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
        <Gapped gap={Number.parseInt(variables.titleContentGap)} vertical={true} className={styles.questionInput}>
            {title && <Label label={title} size={'large'} />}

            {(!hideInput || !preview) && (
                <FileUploader accept={'image/*'} onValueChange={onValueChange} request={uploader} />
            )}

            {preview && <img src={preview} className={styles.imagePreview} alt={''}></img>}
        </Gapped>
    );
};
