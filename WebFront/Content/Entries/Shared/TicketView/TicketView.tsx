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
import { NumericFormat, NumericFormatProps } from 'react-number-format';
import Input from '@mui/joy/Input';

interface TicketViewProps {
    ticket: Ticket;
    ticketNum: number;
    onTicketChange: (ticket: Ticket) => void;
}

interface CustomProps {
    onChange: (event: { target: { name: string; value: string } }) => void;
    name: string;
}

const NumericFormatAdapter = React.forwardRef<NumericFormatProps, CustomProps>(
    function NumericFormatAdapter(props, ref) {
        const { onChange, ...other } = props;
        const isAllowed = (values: any) => {
            const { formattedValue } = values;
            const integerPart = formattedValue.split('.')[0].replace(/\D/g, '');
            return integerPart.length <= 6;
        };

        return (
            <NumericFormat
                {...other}
                getInputRef={ref}
                onValueChange={(values) => {
                    onChange({
                        target: {
                            name: props.name,
                            value: values.value,
                        },
                    });
                }}
                thousandSeparator
                decimalScale={2}
                valueIsNumericString
                prefix="₽ "
                isAllowed={isAllowed}
            />
        );
    },
);

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

    const onFileRemove = async () => {
        onTicketChange(ticket.withCover(undefined));
    };

    const onSizeUpdate = async (qrCodeX?: number, qrCodeY?: number, qrCodeSize?: number) => {
        onTicketChange(ticket.withQr(qrCodeX, qrCodeY, qrCodeSize));
    };

    return (
        <div className={styles.ticketWrapper}>
            <Gapped vertical={true} gap={10}>
                <Label label={`Билет ${ticketNum}`} size={'medium'} />
                <Box sx={{ display: 'flex' }}>
                    <TicketForm
                        backgroundColor="white"
                        borderWidth={1}
                        width={148 * 4}
                        borderColor="black"
                        height={200}
                        polygon="0.00% 0.00%,100.00% 0.00%,100.00% 100%,0.00% 100%"
                    >
                        <TicketImageLoader
                            onRemove={onFileRemove}
                            hideInput={true}
                            uploader={onFileUpload}
                            ticket={ticket}
                            onSizeUpdater={onSizeUpdate}
                        ></TicketImageLoader>
                    </TicketForm>
                </Box>
                <SingleStringQuestion
                    title={'Название'}
                    onValueChange={onChangeTicketName}
                    size={'small'}
                    defaultValue={ticket.Name}
                />
                <Label label={'Стоимость'} size={'small'} />
                <Input
                    value={ticket.Price}
                    onChange={(event) => onChangeTicketPrice(parseFloat(event.target.value))}
                    slotProps={{
                        input: {
                            component: NumericFormatAdapter,
                        },
                    }}
                    sx={{
                        '&.Mui-focused': { borderColor: '#3d3d3d', '--Input-focusedHighlight': '#3d3d3d' },
                        border: '1px solid rgba(0, 0, 0, 0.16)',
                        borderRadius: '2px',
                        transition: 'border-color 100ms cubic-bezier(0.5, 1, 0.89, 1)',
                        boxShadow: 'none',
                        '&:hover': {
                            borderColor: '#3d3d3d',
                        },
                    }}
                />
            </Gapped>
        </div>
    );
};
