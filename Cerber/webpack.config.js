'use strict';

const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
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
            {
                test: /\.(scss|css)$/,
                use: [
                    {
                        loader: MiniCssExtractPlugin.loader,
                        options: {
                            publicPath: path.resolve(__dirname, 'wwwroot', 'css'),
                        },
                    },
                    {
                        loader: 'css-loader',
                        options: {
                            modules: {
                                mode: 'global',
                            },
                        },
                    },
                    'postcss-loader',
                ],
            },
        ],
    },
    plugins: [
        new CleanWebpackPlugin([OUTPUT_PATH]),
        new MiniCssExtractPlugin({ filename: path.join('css', '[name].css') }),
    ],
};
