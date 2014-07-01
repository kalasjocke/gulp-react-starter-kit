gulp = require 'gulp'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
uglify = require 'gulp-uglify'
streamify = require 'gulp-streamify'
source = require 'vinyl-source-stream'
browserify = require 'browserify'
watchify = require 'watchify'
prettyHrtime = require 'pretty-hrtime'


env = process.env.NODE_ENV

gulp.task 'watch', ['setWatch', 'browserify']

gulp.task 'build', ['browserify']

gulp.task 'setWatch', -> global.isWatching = true

gulp.task 'browserify', ->
  bundleMethod = if global.isWatching then watchify else browserify

  bundler = bundleMethod
    entries: ['./src/app.coffee']
    extensions: ['.coffee']

  start = ->
    gutil.log 'Starting', gutil.colors.green("'bundle'") + '...'
    process.hrtime()

  end = (startTime) ->
    taskTime = process.hrtime(startTime)
    prettyTime = prettyHrtime(taskTime)
    gutil.log 'Finished', gutil.colors.green("'bundle'"), 'after', gutil.colors.magenta(prettyTime)

  error = (err) ->
    console.log "error"
    gutil.log 'Error', gutil.colors.red(err)
    @emit 'end'

  bundle = ->
    startTime = start()

    return bundler
      .bundle(debug: true)
      .on('error', error)
      .pipe(source('app.js'))
      .pipe(gulpif(env is 'production', streamify(uglify())))
      .pipe(gulp.dest('./dist/'))
      .on('end', end.bind(@, startTime))

  if global.isWatching
    bundler.on 'update', bundle

  return bundle()
