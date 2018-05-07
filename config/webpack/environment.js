const { environment } = require('@rails/webpacker')
environment.config.externals = ["React","ReactDOM"]

module.exports = environment
