import Vue from 'vue/dist/vue.esm'
import Result from '../result.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#results',
    components: { Result }
  })
})
