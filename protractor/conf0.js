// conf.js
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  specs: ['spec0.js'],
  allScriptsTimeout: 300000,
  jasmineNodeOpts: {
    defaultTimeoutInterval: 300000
  },
  capabilities: {
    browserName: 'firefox'
  }
}
