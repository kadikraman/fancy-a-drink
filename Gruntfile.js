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
        files: ['app/*'],
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
    image: {
      static: {
        files: {
          'dist/assets/images/background.jpg': 'app/assets/images/background.jpg',
          'dist/assets/images/fancy.jpg': 'app/assets/images/fancy.jpg',
          'dist/assets/images/amused.jpg': 'app/assets/images/amused.jpg',
          'dist/assets/images/dirty.jpg': 'app/assets/images/dirty.jpg',
          'dist/assets/images/high.jpg': 'app/assets/images/high.jpg',
          'dist/assets/images/bewildered.jpg': 'app/assets/images/bewildered.jpg',
          'dist/assets/images/crazy.jpg': 'app/assets/images/crazy.jpg',
          'dist/assets/images/question.svg': 'app/assets/images/question.svg'
        }
      }
    },
    copy: {
      main: {
        expand: true,
        cwd: 'app/assets/fonts/',
        src: '**',
        dest: 'dist/assets/fonts/',
        flatten: true,
        filter: 'isFile',
      },
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
  grunt.loadNpmTasks('grunt-image');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('default', ['elm', 'sass', 'image', 'copy', 'open', 'watch']);

};
