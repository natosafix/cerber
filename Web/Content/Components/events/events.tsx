import {Container} from "../container/container";
import Event, {IEvent} from "../event/event";
import React from "react";


interface IProps {
    events: IEvent[];
}

const Events = ({ events }: IProps) => {
    return (
        <Container sku={"123"}>
            {events?.map((p) => (
                <Event event={p} key={p.sku} />
            ))}
        </Container>
    );
};

export default Events;
