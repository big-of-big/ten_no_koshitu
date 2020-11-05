// import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import Result from '../result.vue'

// Vue.use(TurbolinksAdapter)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#results',
    components: { Result }
  })
})
