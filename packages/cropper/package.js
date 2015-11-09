Package.describe({
  name: 'teammalibu:cropper',
  version: '0.0.1',
  summary: 'jquery cropper',
  documentation: 'README.md'
});

Package.onUse(function (api) {
  api.versionsFrom('1.2.1');
  api.use('jquery', 'client');
  api.use('less');
  api.addFiles([
      'cropper.js',
      'cropper.less'
    ], 'client');
});