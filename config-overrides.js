const webpack = require('webpack');

module.exports = function override(config) {
    const fallback = config.resolve.fallback || {};
    Object.assign(fallback, {
        "crypto": require.resolve("crypto-browserify"),
        "stream": require.resolve("stream-browserify"),
        "assert": require.resolve("assert"),
        "http": require.resolve("stream-http"),
        "https": require.resolve("https-browserify"),
        "os": require.resolve("os-browserify"),
        "url": require.resolve("url"),
        "timers": require.resolve("timers-browserify"),
        "vm": require.resolve("vm-browserify"),
        "process/browser": require.resolve("process/browser"),
        "dns": require.resolve("process/browser"),
    })
    config.resolve.fallback = fallback;
    config.plugins.push(
        new webpack.ProvidePlugin({
          process: 'process/browser',
          Buffer: ['buffer', 'Buffer'],
        }),
        new webpack.NormalModuleReplacementPlugin(/node:/, (resource) => {
          const mod = resource.request.replace(/^node:/, '')
          switch (mod) {
            case 'buffer':
              resource.request = 'buffer'
              break
            case 'stream':
              resource.request = 'readable-stream'
              break
            default:
              throw new Error(`Not found ${mod}`)
          }
        }),
      );
    return config;
}

