import Vue from 'vue/dist/vue.esm'
import Result from '../components/result.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({ // eslint-disable-line
    el: '#results',
    components: { Result }
  })
})
