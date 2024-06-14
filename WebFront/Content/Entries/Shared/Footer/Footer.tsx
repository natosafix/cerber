import * as React from 'react';
import styles from './Footer.scss';
import { MaxWidthWrapper } from '../Wrappers/MaxWidthWrapper';
import file from '../../../../Files/Public-Oferta.docx';

export const Footer: React.FC = () => {
    return (
        <footer className={styles.footerWrapper}>
            <MaxWidthWrapper>
                <a href={file}>{'Публичная оферта'}</a>
            </MaxWidthWrapper>
        </footer>
    );
};
