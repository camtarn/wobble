// karma.conf.js 
module.exports = function(config) {
  config.set({
    basePath: '../',
    frameworks: ['jasmine'],
    plugins: ['karma-coffee-preprocessor', 'karma-jasmine', 'karma-spec-reporter'],
    reporters: ['spec'],

    // make sure to include the .coffee files not the compiled .js files 
    files: [
      // bower:js
      "bower_components/jquery/dist/jquery.js",
      "bower_components/angular/angular.js",
      "bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js",
      "bower_components/angular-cookies/angular-cookies.js",
      "bower_components/angular-resource/angular-resource.js",
      "bower_components/angular-route/angular-route.js",
      "bower_components/angular-sanitize/angular-sanitize.js",
      "bower_components/SoundJS/lib/soundjs-0.6.2.combined.js",
      "bower_components/PreloadJS/lib/preloadjs-0.6.2.combined.js",
      "bower_components/underscore/underscore.js",
      "bower_components/angular-mocks/angular-mocks.js",
      // endbower
      'app/scripts/**/*.coffee',
      'test/spec/**/*.coffee'
    ],

    preprocessors: {
      '**/*.coffee': ['coffee']
    },
 
    coffeePreprocessor: {
      // options passed to the coffee compiler 
      options: {
        bare: true,
        sourceMap: false
      },
      // transforming the filenames 
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js');
      }
    }
  });
};
