'use strict';

const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const path = require('path');
const OUTPUT_PATH = path.join(__dirname, '..', 'Web', 'wwwroot');
const PUBLIC_PATH = path.join('/assets');

module.exports = {
    mode: 'development',
    entry: {
        index: './Content/Entries/Pages/Index.tsx',
        eventAdmin: './Content/Entries/Pages/EventAdmin.tsx',
    },
    output: {
        path: OUTPUT_PATH,
        publicPath: PUBLIC_PATH,
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
                test: /\.(s(a|c)ss)$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    {
                        loader: 'css-loader',
                        options: {
                            sourceMap: true,
                            modules: true,
                        },
                    },
                    'postcss-loader',
                    {
                        loader: 'sass-loader',
                        options: {
                            sourceMap: true,
                        },
                    },
                ],
            },
            {
                test: /\.(png|jpg|gif)$/,
                use: [
                    {
                        loader: 'file-loader',
                        options: {
                            publicPath: PUBLIC_PATH,
                            outputPath: 'assets',
                            name: '[path][name].[ext]'
                        },
                    },
                ],
            },
        ],
    },
    plugins: [
        new CleanWebpackPlugin([OUTPUT_PATH]),
        new MiniCssExtractPlugin({ filename: path.join('css', '[name].css') }),
    ],
};
