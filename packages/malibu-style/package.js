Package.describe({
  name: 'teammalibu:malibu-style',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use('flemay:less-autoprefixer@1.2.0');
  api.use('coffeescript');
  api.use('jquery');
  api.addFiles([
    'dist/coffee/feedback.coffee',
    'dist/coffee/loader.coffee',
    'dist/coffee/malibu.coffee',
    'dist/coffee/modal.coffee',
    'dist/coffee/tags.coffee',
  ], 'client');
  api.addFiles([
    'dist/less/malibu.import.less',
    'dist/less/global/normalize.import.less',
    'dist/less/global/fonts.import.less',
    'dist/less/global/body.import.less',
    'dist/less/global/reset.import.less',
    'dist/less/global/variables.import.less',
    'dist/less/global/mixins.import.less',
    'dist/less/global/malibu.import.less',

    'dist/less/site/typography.import.less',

    'dist/less/structure/structure.import.less',

    'dist/less/components/buttons/buttons.import.less',
    'dist/less/components/buttons/buttons-mixin.import.less',
    'dist/less/components/tags/tags.import.less',
    'dist/less/components/modals/modals.import.less',
    'dist/less/components/feedback/feedback.import.less',
    'dist/less/components/loader/fullpage-loader.import.less'
  ], 'client', {isImport: true});
});

// Package.onTest(function(api) {
//   api.use('ecmascript');
//   api.use('tinytest');
//   api.use('teammalibu:malibu');
//   api.addFiles('malibu-tests.js');
// });

