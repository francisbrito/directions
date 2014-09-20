var gulp = require('gulp');
var util = require('gulp-util');
var rename = require('gulp-rename');
var coffee = require('gulp-coffee');
var del    = require('del');

gulp.task('clean', function (fn) {
  del('./lib', fn);
});

gulp.task('default', ['clean'], function () {
  gulp.src('./src/core.coffee')
    .pipe(coffee({bare: true}).on('error', util.log))
    .pipe(rename('directions.js'))
    .pipe(gulp.dest('./lib/'));
});
