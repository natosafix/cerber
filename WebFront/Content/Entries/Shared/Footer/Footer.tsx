import * as React from 'react';
import { Button, Gapped } from '@skbkontur/react-ui';
import styles from './Footer.scss';
import { MaxWidthWrapper } from '../Wrappers/MaxWidthWrapper';
import file from '../../../../Files/Public-Oferta.docx';

export const Footer: React.FC = () => {
    return (
        <footer className={styles.headerWrapper}>
            <MaxWidthWrapper>
                <div className={styles.headerSpaceBetweenWrapper}>
                    <Gapped gap={20} verticalAlign={'middle'}>
                        <a href={file}>{'Публичная оферта'}</a>
                    </Gapped>
                </div>
            </MaxWidthWrapper>
        </footer>
    );
};
