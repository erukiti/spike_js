'use strict'

LOCAL_PROCESS_PORT = 10000

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-coffeelint'
  require('time-grunt')(grunt)

  grunt.initConfig
    connect:
      server:
        options:
          port: LOCAL_PROCESS_PORT
          hostname: 'localhost'
          base: [
            'dist',
            'app'
          ]
          open: true

    watch:
      coffee:
        files: "app/module/**/*.coffee"
        tasks: ["coffee", "coffeelint"]

    coffee:
      compile:
        files: [
          expand: true
          cwd: 'app/module/'
          src: ['**/*.coffee']
          dest: 'dist/module/'
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

  grunt.registerTask "serve", [
    "coffee", 
    "coffeelint"
    "connect", 
    "watch:coffee"
  ]

  grunt.registerTask "test", [
    "coffee",
    "coffeelint"
    "karma"
  ]