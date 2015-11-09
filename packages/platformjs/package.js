Package.describe({
  name: 'teammalibu:platformjs',
  version: '0.0.1',
  summary: 'platform js',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.addFiles('platformjs.js', 'client');
});