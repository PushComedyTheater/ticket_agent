const CopyWebpackPlugin = require('copy-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin');
// const SentryPlugin = require('@sentry/webpack-plugin');
const ManifestPlugin = require('webpack-manifest-plugin');

const path = require('path');

// the path(s) that should be cleaned
let pathsToClean = [
  './priv/static'
]

// the clean options to use
let cleanOptions = {
  verbose: true,
  dry: false,
  allowExternal: true,
  root: '/Users/patrickveverka/Code/ticket_agent/apps/ticket_agent_web/'
}

module.exports = {
  entry: {
    application: ['./js/app.js', './js/hs.count-qty.js'],
    stripe_related: ['./js/stripe_response_parser.js', './js/stripe_related.js'],
    ticket_related: ['./js/ticket_related.js'],
    admin: './js/admin/admin.js',
    new_listing: ['./js/admin/listing/new.js'],
    edit_listing: ['./js/admin/listing/edit.js'],
    concierge: './js/concierge/checkin.js'
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js/'),
    sourceMapFilename: "[name].js.map",
  },
  context: path.join(__dirname, ''),
  plugins: [
    new CleanWebpackPlugin(pathsToClean, cleanOptions),
    new CopyWebpackPlugin([
      // {output}/file.txt
      {
        from: './images',
        to: '../images/'
      },
      {
        from: './static/apple-developer-merchantid-domain-association',
        to: '../.well-known/'
      }
    ]),
    new ManifestPlugin({
      fileName: '../cache_manifest.json',
    })
    // new SentryPlugin({
    //     release: function (hash) {
    //       return hash.slice(0, 5)
    //     },
    //     include: './dist',
    //     ignore: ['node_modules', 'webpack.config.js'],
    // }),
  ],
  module: {
    rules: [{
        test: /\.handlebars$/,
        loader: "handlebars-loader?helperDirs[]=./helpers",
        query: {
          precompileOptions: {
            knownHelpersOnly: false
          }
        }
      },
      {
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          }
        }
      }
    ]
  }
};