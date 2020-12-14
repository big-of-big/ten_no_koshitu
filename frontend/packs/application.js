// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap'
import 'flatpickr'

import '../stylesheets/application'
import '@fortawesome/fontawesome-free/js/fontawesome'
import '@fortawesome/fontawesome-free/js/solid'
import '@fortawesome/fontawesome-free/js/regular'

require('@rails/ujs').start()
require('@rails/activestorage').start()
require('channels')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true) // eslint-disable-line
// const imagePath = (name) => images(name, true)

document.addEventListener('DOMContentLoaded', () => {
  const flashMessage = document.querySelector('.alert-success')
  const fadeOutFlashMessage = () => {
    const timerId = setInterval(() => {
      const opacity = flashMessage.style.opacity

      if (opacity > 0) {
        flashMessage.style.opacity = opacity - 0.02
      } else {
        flashMessage.style.display = 'none'
        clearInterval(timerId)
      };
    }, 50) // 今回は0.05秒ごとにsetIntervalを実行
  }

  if (flashMessage !== null) {
    flashMessage.style.opacity = 1
    setTimeout(fadeOutFlashMessage, 3000)
  }
})
