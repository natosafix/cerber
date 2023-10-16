'use strict';

const CleanWebpackPlugin = require('clean-webpack-plugin');
const path = require('path');
const OUTPUT_PATH = path.join(__dirname, 'wwwroot');

module.exports = {
    mode: 'development',
    entry: {
        index: './Content/entries/pages/index.tsx',
    },
    output: {
        path: OUTPUT_PATH,
        filename: path.join('js', '[name].js'),
    },
    watch: true,
    devtool: 'source-map',
    resolve: {
        extensions: ['.tsx', '.ts', '.js', '.jsx', '.scss'],
    },
    module: {
        rules: [
            {
                test: /\.tsx?$/,
                use: 'ts-loader',
                exclude: /node_modules/,
            },
        ],
    },
    plugins: [new CleanWebpackPlugin([OUTPUT_PATH])],
};
