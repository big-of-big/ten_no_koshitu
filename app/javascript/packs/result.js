import Vue from 'vue/dist/vue.esm'
import Result from '../result.vue'

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#results',
    components: { Result }
  })
})
