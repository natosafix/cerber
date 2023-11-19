import React, { useEffect, useState } from 'react';
import styles from '../eventAdmin.scss';
import variables from '../eventAdminVariables.scss';
import { FileUploader, FileUploaderAttachedFile, Gapped } from '@skbkontur/react-ui';


interface IImageLoaderQuestion {
    storageSaver: ILocalStorageSaver;
    title: string;
}

export const ImageLoader: React.FC<IImageLoaderQuestion> = ({ title, storageSaver }) => {
    const [selectedFile, setSelectedFile] = useState<File | undefined>();
    const [preview, setPreview] = useState<string | undefined>();

    useEffect(() => {
        if (!selectedFile) {
            setPreview(undefined);
            return;
        }

        const objectUrl = URL.createObjectURL(selectedFile);
        setPreview(objectUrl);

        return () => URL.revokeObjectURL(objectUrl);

    }, [selectedFile]);

    let onFileLoad = (files: FileUploaderAttachedFile[]) => {
        if (files.length === 0) {
            setSelectedFile(undefined);
            return;
        }

        let file = files[0].originalFile;
        setSelectedFile(file);
    };

    return (
        <Gapped gap={Number.parseInt(variables.titleContentGap)}
                vertical={true}
                className={styles.questionInput}>
            <div className={styles.questionLabel}>{title}</div>
            <FileUploader accept={'image/*'} onValueChange={onFileLoad} />
            {preview && (
                <img src={preview} alt={'loaded image'} className={styles.imagePreview} />
            )}
        </Gapped>
    );
};