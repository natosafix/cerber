import React, { useEffect, useRef, useState } from 'react';
import styles from '../EventAdmin.scss';
import variables from '../EventAdminVariables.scss';
import { FileUploader, FileUploaderAttachedFile, Gapped } from '@skbkontur/react-ui';


interface IImageLoaderQuestion {
    storageSaver: ILocalStorageSaver;
    title: string;
}

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

export const ImageLoader: React.FC<IImageLoaderQuestion> = ({ title, storageSaver }) => {
    const [selectedFile, setSelectedFile] = useState<Blob | undefined>();
    let firstRender = useRef(true);
    const [preview, setPreview] = useState<string | undefined>();

    useEffect(() => {
        let savedPreview = storageSaver.load(title);
        if (savedPreview) {
            let blob = base64toBlob(savedPreview);
            setSelectedFile(blob);
        }
    }, []);
    
    useEffect(() => {
        if (firstRender.current) {
            firstRender.current = false;
            return;
        }
        if (!selectedFile) {
            storageSaver.delete(title);
            setPreview(undefined);
            return;
        }

        let objectUrl = URL.createObjectURL(selectedFile);

        const reader = new FileReader();
        reader.onload = () => {
            if (typeof reader.result === 'string') {
                storageSaver.save(title, reader.result);
            }
        };
        reader.readAsDataURL(selectedFile);

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