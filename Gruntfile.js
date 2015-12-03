module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          'dist/app.js': ['app/Main.elm']
        }
      }
    },
    watch: {
      elm: {
        files: ['app/Main.elm'],
        tasks: ['elm']
      },
      sass: {
        files: ['app/style.scss'],
        tasks: ['sass']
      }
    },
    sass: {
      dist: {
        files: {
          'dist/style.css': 'app/style.scss'
        }
      }
    },
    open: {
      file : {
        path : 'index.html'
      }
    },
    clean: ['elm-stuff/build-artifacts']
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-open');

  grunt.registerTask('default', ['elm', 'sass', 'open', 'watch']);

};
