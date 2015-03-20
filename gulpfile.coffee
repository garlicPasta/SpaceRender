gulp = require 'gulp'
gutil = require 'gulp-util'
sourcemaps = require 'gulp-sourcemaps'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
watchify = require 'watchify'
browserify = require 'browserify'
shell = require 'gulp-shell'
coffeelint = require 'gulp-coffeelint'

watchify.args.extensions = ['.coffee']
bundler = watchify(browserify('./src/RenderService.coffee', watchify.args))

bundle = ->
    return bundler.bundle()
        # log errors if they happen
        .on('error', gutil.log.bind(gutil, 'browserify error'))
        .pipe(source('./bundle.js'))
         # optional, remove if you dont want sourcemaps
            .pipe(buffer())
            .pipe(sourcemaps.init({loadmaps: true})) # loads map from browserify file
            .pipe(sourcemaps.write('./')) # writes .map file
        .pipe(gulp.dest('./build'))

# add any other browserify options or transforms here
#bundler.extensions(['.coffee'])
bundler.transform('coffeeify')

gulp.task 'js', bundle
bundler.on('update', bundle) # on any dep update, runs the bundler
bundler.on('log', gutil.log) # output build logs to terminal

gulp.task 'default', ['js', 'nodemon']

gulp.task('nodemon', shell.task([
 'npm run-script nodemon'
]))

gulp.task('mocha', shell.task([
 'npm test'
]))

gulp.task 'test', ['js', 'mocha' ]

gulp.task 'lint', ->
    gulp.src(['./src/*.coffee', './test/*.coffee'])
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
        .pipe(coffeelint.reporter('fail'))

