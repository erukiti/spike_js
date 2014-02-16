'use strict'

LOCAL_PROCESS_PORT = 10000

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-ngmin'
  grunt.loadNpmTasks 'grunt-usemin'
  require('time-grunt')(grunt)

  grunt.initConfig
    connect:
      server:
        options:
          port: LOCAL_PROCESS_PORT
          hostname: 'localhost'
          base: [
            'dist',
            'app',
            '.tmp'
          ]
          open: true

    watch:
      coffee:
        files: "app/module/**/*.coffee"
        tasks: ["coffee", "coffeelint"]

      compass:
        files: "app/styles/**/*.{scss,sass}"
        tasks: ["compass:server"]

    coffee:
      compile:
        files: [
          expand: true
          cwd: 'app/module/'
          src: ['**/*.coffee']
          dest: '.tmp/module/'
          ext: '.js'
        ]

    karma:
      unit:
        configFile: 'karma.conf.js'
        singleRun: true
        browsers: ['PhantomJS']

    coffeelint:
      options:
        no_plusplus:
          level: 'error'
        cyclomatic_complexity:
          value: 10
          level: 'error'
      app:
        files:
          src: ['app/module/**/*.coffee']
        options:
          max_line_length:
            value: 120
            level: 'warn'

      test:
        files:
          src: ['test/spec/**/*.spec.coffee']
        options:
          max_line_length:
            value: 140
            level: 'warn'

    compass:
      options:
        sassDir: 'app/styles'
        cssDir: 'dist/styles'
      server:
        options:
          debugInfo: true

    clean:
      dist:
        files: [
          dot: true
          src: [
            '.tmp',
            'dist'
          ]
        ]

    useminPrepare:
      html: 'app/index.html'
      options:
        dest: 'dist'

    htmlmin:
      dist:
        files:[
          expand: true
          cwd: 'app'
          src: ['*.html']
          dest: 'dist'
        ]

    ngmin:
      dist:
        files: [
          expand: true
          cwd: '.tmp/concat/scripts'
          src: '*.js'
          dest: '.tmp/concat/scripts'
        ]

    copy:
      dist:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: 'dist'
          src: [
            'bower_components/**/*'
          ]
        ]

    usemin:
      html: ['dist/**/*.html']
      css: ['dist/styles/**/*.css']

  grunt.registerTask "serve", [
    'clean',
    "coffee", 
    "coffeelint",
    "compass:server",
    "connect", 
    "watch"
  ]

  grunt.registerTask "test", [
    "coffee",
    "coffeelint",
    "compass:server",
    "karma"
  ]

  grunt.registerTask "build", [
    'clean'
    'useminPrepare',
    'coffee',
    "coffeelint",
    "compass",
    "htmlmin",
    "concat",
    "ngmin",
    "copy:dist",
    "uglify",
    "usemin"
  ]
