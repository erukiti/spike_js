'use strict'

LOCAL_PROCESS_PORT = 10000

module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-contrib'

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
        tasks: ["coffee"]

    coffee:
      compile:
        files: [
          expand: true
          cwd: 'app/module/'
          src: ['**/*.coffee']
          dest: 'dist/module/'
          ext: '.js'
        ]
    # ngmin:

          # 'dist/all.js': [
          #   "app/modules/**/*.coffee"
          # ]

  grunt.registerTask "serve", [
    "coffee", 
    "connect", 
    "watch:coffee"
  ]
