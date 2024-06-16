import React from 'react';
import { Ticket } from './Ticket';
import { CurrencyInput, FileUploaderAttachedFile, Gapped } from '@skbkontur/react-ui';
import { Label } from '../Label/Label';
import { SingleStringQuestion } from '../Questions/SingleStringQuestion';
import styles from './TicketView.scss';
import { TicketForm } from './TicketForm/TicketForm';
import { Box } from '@mui/material';
import { TicketImageLoader } from './TicketImageLoader/TicketImageLoader';
import { EventAdminClient } from '../../../../Api/EventAdmin/EventAdminClient';

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
        console.log(v);
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
                        width={148 * 4}
                        borderColor="black"
                        height={200}
                        polygon="0.00% 0.00%,100.00% 0.00%,100.00% 100%,0.00% 100%"
                    >
                        <TicketImageLoader hideInput={true} uploader={onFileUpload} ticket={ticket}></TicketImageLoader>
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
