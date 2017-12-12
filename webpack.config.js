const Path = require('path');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const OfflinePlugin = require('offline-plugin');

const extractPlugin = new ExtractTextPlugin({
  filename: '[name].css'
});

module.exports = {
  entry: {
    global: './source/assets/javascripts/global.js',
    index: './source/assets/javascripts/index.js'
  },

  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader'
        }
      },
      {
        test: /\.(woff|woff2)$/,
        loader: 'file-loader',
        options: {
          name: 'fonts/[name].[ext]'
        }
      },
      {
        test: /\.scss$/,
        use: extractPlugin.extract({
          use: ['css-loader', 'postcss-loader', 'sass-loader']
        })
      }
    ]
  },

  plugins: [
    extractPlugin,
    new OfflinePlugin({
      publicPath: '/'
    }),
    new CleanWebpackPlugin(['.tmp/dist'])
  ],

  output: {
    path: Path.resolve(__dirname, '.tmp', 'dist'),
    filename: '[name]-bundle.js',
    publicPath: '.tmp/dist/'
  }
};
