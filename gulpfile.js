var gulp = require('gulp'),
    gulpif = require('gulp-if'),
    uglify = require('gulp-uglify'),
    streamify = require('gulp-streamify'),
    source = require('vinyl-source-stream'),
    browserify = require('browserify');

var production = true;

gulp.task('js', function() {
  var bundler = browserify({
    entries: ['./src/app.coffee'],
    extensions: ['.coffee']
  });

  return bundler
    .bundle({debug: !production})
    .pipe(source('app.js'))
    .pipe(gulpif(production, streamify(uglify())))
    .pipe(gulp.dest('./dist/'));
});
