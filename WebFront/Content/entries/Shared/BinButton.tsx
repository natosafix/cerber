import React from 'react';
import img from '../../Images/bin.png'

export const BinButton: React.FC = () => {
    return (
        <button>
            <img src={img} alt="remove" />
        </button>
    );
}