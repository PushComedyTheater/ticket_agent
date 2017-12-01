const CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

module.exports = {
  entry: {
    application: ['./js/app.js', './js/hs.count-qty.js'],
    admin: './js/admin/admin.js'
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, '../priv/static/js/')
  },
  context: path.join(__dirname, ''),
  plugins: [
    new CopyWebpackPlugin([
      // {output}/file.txt
      { from: './images', to: '../images/' },
    ])
  ]
};
