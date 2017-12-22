const CopyWebpackPlugin = require('copy-webpack-plugin');
const SentryPlugin = require('@sentry/webpack-plugin');
const path = require('path');

module.exports = {
  entry: {
    application: ['./js/app.js', './js/hs.count-qty.js'],
    stripe_related: ['./js/stripe_response_parser.js', './js/stripe_related.js'],
    ticket_related: ['./js/ticket_related.js'],
    admin: './js/admin/admin.js'
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js/'),
    sourceMapFilename: "[name].js.map",
  },
  context: path.join(__dirname, ''),
  plugins: [
    new CopyWebpackPlugin([
      // {output}/file.txt
      { from: './images', to: '../images/' },
      {
        from: './static/apple-developer-merchantid-domain-association',
        to: '../.well-known/'
      }
    ]),
    new SentryPlugin({
        release: function (hash) {
          return hash.slice(0, 5)
        },
        include: './dist',
        ignore: ['node_modules', 'webpack.config.js'],
    })
  ]
};
