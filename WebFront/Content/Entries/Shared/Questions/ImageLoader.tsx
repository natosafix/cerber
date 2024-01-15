import React, { useEffect, useRef, useState } from 'react';
import styles from './QuestionStyles.scss';
import variables from './QuestionVariables.scss';
import { FileUploader, FileUploaderAttachedFile, Gapped } from '@skbkontur/react-ui';
import { Label } from '../Label/Label';


interface IImageLoaderQuestion {
    title: string;
    defaultUrl: string | null | undefined;
    uploader: (file: FileUploaderAttachedFile) => Promise<void>;
    onRemove: () => void;
}

// Жалко удалять
const base64toBlob = (base64Data: string): Blob => {
    let startIdx = base64Data.indexOf("base64,");
    if (startIdx === -1) {
        startIdx = 0;
    } else {
        startIdx += 7;
    }
    base64Data = base64Data.substring(startIdx);
    
    const sliceSize = 1024;
    const byteCharacters = atob(base64Data);
    const bytesLength = byteCharacters.length;
    const slicesCount = Math.ceil(bytesLength / sliceSize);
    const byteArrays = new Array(slicesCount);

    for (let sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
        const begin = sliceIndex * sliceSize;
        const end = Math.min(begin + sliceSize, bytesLength);

        const bytes = new Array(end - begin);
        for (let offset = begin, i = 0; offset < end; ++i, ++offset) {
            bytes[i] = byteCharacters[offset].charCodeAt(0);
        }
        byteArrays[sliceIndex] = new Uint8Array(bytes);
    }
    
    return new Blob(byteArrays, { type: '' });
}

export const ImageLoader: React.FC<IImageLoaderQuestion> = ({ title, defaultUrl, uploader, onRemove }) => {
    const [selectedFile, setSelectedFile] = useState<Blob | undefined>();
    const [preview, setPreview] = useState<string | null | undefined>(defaultUrl);
    let firstRender = useRef(true);

    const onValueChange = (files: FileUploaderAttachedFile[]) => {
        if (files.length === 0) {
            onRemove();
            setSelectedFile(undefined);
            return;
        }
        if (files[0].status === 'Uploaded') {
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
        <Gapped gap={Number.parseInt(variables.titleContentGap)}
                vertical={true}
                className={styles.questionInput}>
            <Label label={title} size={"large"}/>
            <FileUploader accept={'image/*'}
                          onValueChange={onValueChange}
                          request={uploader}/>
            {preview && (
                <img src={preview} className={styles.imagePreview} alt={''}/>
            )}
        </Gapped>
    );
};
