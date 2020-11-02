import Vue from 'vue/dist/vue.esm'
import Hoge from '../table.vue'

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#table',
    data: {
      all: true,
      start: '',
      end: ''
    },
    components: { Hoge },
    computed: {
      changeAll: {
        get: function () {
          return this.all
        },
        set: function (boolean) {
          this.all = boolean
          if (this.all === true) {
            this.start = ''
            this.end = ''
          }
        },
      },
      changeStart: {
        get: function () {
          return this.start
        },
        set: function (date) {
          this.start = date
          if (!(this.start === '')) {
            this.all = false
          }
        }
      },
      changeEnd: {
        get: function () {
          return this.end
        },
        set: function (date) {
          this.end = date
          if (!(this.end === '')) {
            this.all = false
          }
        }
      }
    }
  })
})
