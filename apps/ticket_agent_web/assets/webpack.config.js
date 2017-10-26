const path = require('path');

module.exports = {
  entry: './js/app.js',
  output: {
    filename: 'application.js',
    path: path.resolve(__dirname, '../priv/static/js/')
  }
};
