Package.describe({
  name: 'teammalibu:momentjs-kr',
  version: '0.0.1',
  summary: 'Moment.js ko locale. ',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use('momentjs:moment@2.10.6');
  api.imply('momentjs:moment');
  api.addFiles('momentjs-kr.js');
});