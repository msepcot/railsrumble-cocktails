// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// $ = jQuery. window = this. undefined = undefined.
(function ($, window, undefined) {
  'use strict';

  var Cocktails = {
    init: function () {
      this.bindEvents();
    },

    bindEvents: function () {
      $('.button').on('click', function (event) {
        event.preventDefault();
      });
    }
  };

  $(document).ready(function () {
    Cocktails.init();
  });

}(jQuery, this));
