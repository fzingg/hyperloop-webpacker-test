process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
environment.config.externals = ["React","ReactDOM"]

module.exports = environment.toWebpackConfig()
