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
    const [inspectors, setInspectors] = useState<string[]>([]);
    const [ticketsRows, setTicketsRows] = useState<Row[]>([]);
    const [inspectorsRows, setInspectorsRows] = useState<Map<string, Row[]>>(new Map);

    useEffect(() => {
        EventsClient.getEventStats(event.id)
            .then(response => {
                const eventStats = response.data;
                setTicketsRows(eventStats.ticketsStats
                    .map(ts => createRow(ts.name, ts.quantity, ts.price)));
                if (eventStats.inspectors.length === 0)
                    return;
                setInspectors(eventStats.inspectors);
                let inspectorsRowsInternal = new Map<string, Row[]>();
                for (const inspector of eventStats.inspectors) {
                    inspectorsRowsInternal[inspector] = eventStats.ticketsByInspector[inspector]
                        .map(ts => createRow(ts.name, ts.quantity, ts.price));
                }
                setInspectorsRows(inspectorsRowsInternal);
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
        name: string;
        qty: number;
        unit: number;
        price: number;
    }

    function createRow(name: string, qty: number, unit: number) {
        const price = priceRow(qty, unit);
        return { name, qty, unit, price };
    }

    function subtotal(items: readonly Row[]) {
        return items.map(({ price }) => price).reduce((sum, i) => sum + i, 0);
    }

    const getInspectorsRows = () => {
        let elements: React.JSX.Element[] = [];
        for (const inspector of inspectors) {
            let jsxRows = inspectorsRows[inspector].map((row, i) => (
                <TableRow key={row.name}>
                    {i == 0 && <TableCell rowSpan={inspectorsRows[inspector].length}>{inspector}</TableCell>}
                    <TableCell align="right">{row.name}</TableCell>
                    <TableCell align="right">{row.qty}</TableCell>
                    <TableCell align="right">{row.unit}</TableCell>
                    <TableCell align="right">{ccyFormat(row.price)}</TableCell>
                </TableRow>
            ))
            elements = elements.concat(jsxRows);
            elements.push(
                <TableRow>
                    <TableCell colSpan={3} />
                    <TableCell align="center">Итого</TableCell>
                    <TableCell colSpan={2} align="right">{ccyFormat(subtotal(inspectorsRows[inspector]))}</TableCell>
                </TableRow>);
        }
        return elements;
    }

    return (
        <div>
            {ticketsRows.length > 0 &&
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
                            {ticketsRows.map((row) => (
                                <TableRow key={row.name}>
                                    <TableCell>{row.name}</TableCell>
                                    <TableCell align="right">{row.qty}</TableCell>
                                    <TableCell align="right">{row.unit}</TableCell>
                                    <TableCell align="right">{ccyFormat(row.price)}</TableCell>
                                </TableRow>
                            ))}
                            <TableRow>
                                <TableCell colSpan={2} />
                                <TableCell align="center">Итого</TableCell>
                                <TableCell align="right">{ccyFormat(subtotal(ticketsRows))}</TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </TableContainer>
            }
            <br/>
            {inspectors.length > 0 &&
                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 700 }} aria-label="spanning table">
                        <TableHead>
                            <TableRow>
                                <TableCell>Проверяющий</TableCell>
                                <TableCell align="right">Билет</TableCell>
                                <TableCell align="right">Количество</TableCell>
                                <TableCell align="right">Цена</TableCell>
                                <TableCell align="right">Сумма</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {getInspectorsRows()}
                        </TableBody>
                    </Table>
                </TableContainer>
            }
        </div>
    );
};
