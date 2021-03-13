module.exports = {
  mode: 'production',
  output: {
    libraryTarget: "var",
    library: "javascript",
  },
  node: {
    fs: "empty",
    child_process: "empty",
  },
};
