// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require('./cepNumber.js')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import bulmaQuickview from 'bulma-quickview/src/js'

document.addEventListener('turbolinks:load', function() {
    let quickviews = bulmaQuickview.attach()
})

$(document).on('turbolinks:load', function() {

  $('form').on('click', '.remove_record', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    let regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
});
      
document.addEventListener("turbolinks:load", function() {

  let notification = document.querySelector('.global-notification');
  if(notification) {
    window.setTimeout(function() {
      notification.style.display = "none";
    }, 4000);
  }

  $(".navbar-burger").click(function() {    
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });

  $(".showModal").click(function() {
    $(".modal").addClass("is-active");  
  });
  
  $(".modal-close").click(function() {
     $(".modal").removeClass("is-active");
  });

});

document.addEventListener("turbolinks:load", function() {
  let slideIndex = 1;
  let url = window.location.href;
  
  if (url.includes('/products/')) {
    showSlides(slideIndex)
  }
  $(".prev-slider").click(function() {
    showSlides(slideIndex += -1);
  });
  $(".next-slider").click(function() {
    showSlides(slideIndex += -1);
  });

  function showSlides(n) {
    let i;
    let slides = $(".mySlides");
    if (n > slides.length) {slideIndex = 1}
    if (n < 1) {slideIndex = slides.length}
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    
    slides[slideIndex-1].style.display = "block";
  }
});


document.addEventListener("turbolinks:load", function() {

  $(".filter-mobile-button").click(function() {
    $(".filter-mobile").toggle();
    $(".categories-mobile").hide();
  });
  $(".categories-mobile-button").click(function() {
    $(".categories-mobile").toggle();
    $(".filter-mobile").hide();
  });

});

document.addEventListener('turbolinks:load', function() {
  const fileInput = document.querySelectorAll('input[type=file].file-input')
  fileInput.forEach(input => {
    input.onchange = () => {
      if (input.files.length > 0) {
        const fileName = input.parentNode.querySelector(".file-name")
        fileName.textContent = input.files[0].name
      }
    }
  })
})