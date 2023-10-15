"use strict";

module.exports = {
    mode: 'development',
    entry: "./Content/entries/pages/index.tsx",
    output: {
        filename: "./dist/reactApp.js"
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
                exclude: /node_modules/
            },
        ]
    }
}