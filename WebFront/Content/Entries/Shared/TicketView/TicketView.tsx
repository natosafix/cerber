import React from 'react';
import { Ticket } from './Ticket';
import { CurrencyInput, FileUploaderAttachedFile, Gapped } from '@skbkontur/react-ui';
import { Label } from '../Label/Label';
import { SingleStringQuestion } from '../Questions/SingleStringQuestion';
import styles from './TicketView.scss';
import { TicketForm } from './TicketForm/TicketForm';
import { Box } from '@mui/material';
import { TicketImageLoader } from './TicketImageLoader/TicketImageLoader';
import { ValidationWrapper } from '@skbkontur/react-ui-validations';
import { Nullable } from '@skbkontur/react-ui/typings/utility-types';
import { ValidationInfo } from '@skbkontur/react-ui-validations/src/ValidationWrapper';

interface TicketViewProps {
    ticket: Ticket;
    ticketNum: number;
    onTicketChange: (ticket: Ticket) => void;
}

export const TicketView: React.FC<TicketViewProps> = ({ ticket, ticketNum, onTicketChange }) => {
    const onChangeTicketName = (v: string) => {
        onTicketChange(ticket.withName(v));
    };

    const onChangeTicketPrice = (v?: number) => {
        // TODO не присылает ивент, если стёрли значение
        onTicketChange(ticket.withPrice(v));
    };

    const onFileUpload = async (file: FileUploaderAttachedFile) => {
        onTicketChange(ticket.withCover(file.originalFile));
    };

    return (
        <div className={styles.ticketWrapper}>
            <Gapped vertical={true} gap={10}>
                <Label label={`Билет ${ticketNum}`} size={'medium'} />
                <Box sx={{ display: 'flex' }}>
                    <TicketForm
                        backgroundColor="white"
                        borderWidth={2}
                        width={((148 * 4) / 3) * 2}
                        borderColor="black"
                        height={200}
                        polygon="0.00% 0.00%,100.00% 0.00%,100.00% 100%,0.00% 100%"
                    ></TicketForm>
                    <TicketForm
                        backgroundColor="white"
                        borderWidth={2}
                        width={(148 * 4) / 3}
                        borderColor="black"
                        height={200}
                        margin={'0 0 0 -1px'}
                        polygon="91.74% 0.00%,100.00% 12.57%,100.00% 87.04%,93.14% 100%,0.00% 100%,0.00% 0.00%"
                    >
                        <TicketImageLoader hideInput={true} uploader={onFileUpload}></TicketImageLoader>
                    </TicketForm>
                </Box>
                <SingleStringQuestion
                    title={'Название'}
                    onValueChange={onChangeTicketName}
                    size={'small'}
                    defaultValue={ticket.Name}
                />
                <Label label={'Стоимость'} size={'small'} />
                <CurrencyInput
                    fractionDigits={0}
                    onValueChange={onChangeTicketPrice}
                    size={'small'}
                    value={ticket.Price}
                />
            </Gapped>
        </div>
    );
};
