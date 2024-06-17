import React, { useEffect, useState } from 'react';
import { IEvent } from '../EventPreview/Models/IEvent';
import { EventsClient } from '../../../Api/Events/EventsClient';
import { IEventStats } from '../../../Api/Events/IEventStats';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

interface IEventsProps {
    event: IEvent;
}

export const EventStats: React.FC<IEventsProps> = ({ event }) => {
    const [rows, setRows] = useState<Row[]>([]);

    useEffect(() => {
        EventsClient.getEventStats(event.id)
            .then(response => {
                const eventStats = response.data;
                console.log(eventStats);
                setRows(eventStats.ticketsStats
                    .map(ts => createRow(ts.name, ts.quantity, ts.price)));
            })
            .catch(reason => console.error(reason));
    }, []);

    function ccyFormat(num: number) {
        return `${num.toFixed(2)}`;
    }

    function priceRow(qty: number, unit: number) {
        return qty * unit;
    }

    interface Row {
        desc: string;
        qty: number;
        unit: number;
        price: number;
    }

    function createRow(desc: string, qty: number, unit: number) {
        const price = priceRow(qty, unit);
        return { desc, qty, unit, price };
    }

    function subtotal(items: readonly Row[]) {
        return items.map(({ price }) => price).reduce((sum, i) => sum + i, 0);
    }

    return (
        <div>
            {rows.length > 0 &&
                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 700 }} aria-label="spanning table">
                        <TableHead>
                            <TableRow>
                                <TableCell>Билет</TableCell>
                                <TableCell align="right">Количество</TableCell>
                                <TableCell align="right">Цена</TableCell>
                                <TableCell align="right">Сумма</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {rows.map((row) => (
                                <TableRow key={row.desc}>
                                    <TableCell>{row.desc}</TableCell>
                                    <TableCell align="right">{row.qty}</TableCell>
                                    <TableCell align="right">{row.unit}</TableCell>
                                    <TableCell align="right">{ccyFormat(row.price)}</TableCell>
                                </TableRow>
                            ))}
                            <TableRow>
                                <TableCell colSpan={2} />
                                <TableCell align="center">Итого</TableCell>
                                <TableCell align="right">{ccyFormat(subtotal(rows))}</TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </TableContainer>
            }
        </div>
    );
};
