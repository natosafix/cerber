
import {Container} from "../container/container";
import {Image} from "../image/image";
import React from "react";
import {Title} from "../title/title";

export interface IEvent {
    sku: number;
    title: string;
}

interface IProps {
    event: IEvent;
}

const Event = ({ event }: IProps) => {
    const {
        sku,
        title,
    } = event;



    return (
        <Container sku={sku}>
            <Image/>
            <Title>{title}</Title>
        </Container>
    );
};

export default Event;
