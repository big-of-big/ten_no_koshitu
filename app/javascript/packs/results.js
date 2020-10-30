import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('turbolinks:load', () => {
  const app = new Vue({
    el: '#results',
    data: {
      message: "",
    },
    components: { App }
  })
})
