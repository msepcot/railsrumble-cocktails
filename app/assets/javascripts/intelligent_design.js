// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function IntelligentDesign() {}

IntelligentDesign.prototype.concoct = function () {
  var ingredients, success, error;

  ingredients = $.map($('input:checked'), function (checkbox) {
    return $(checkbox).val();
  });

  success = function (data) {
    this.showDrinks(data);
    $('.alert').addClass('hidden');
  };

  fail = function (jqXHR, textStatus, errorThrown) {
    var $alert = $('.alert');

    $alert.children('h4').text('There was an error!');
    $alert.children('p').text(errorThrown.message);
    $alert.removeClass('hidden');

    throw new Error(errorThrown);
  };

  $.getJSON('/godmode', { ingredients: ingredients }, success).fail(fail)
}

IntelligentDesign.prototype.showDrinks = function (drinks) {
  $('#drinks').html(drinks.html);
  $('#selection').slideUp();

  // Toggles visibility of drink details.
  $('.drink').on('click', function (event) {
    $(event.target).next('.drink-info').slideToggle('fast');
  });

  $('#again').on('click', function (event) {
    event.preventDefault();

    $('#selection').show();
    $('html, body').animate({
      scrollTop: 0
    }, function () {
      $('input[type="checkbox"]').attr('checked', false);
      $('#drinks').empty();
    });
  });
};

$(function () {
  var iDesign = new IntelligentDesign();

  $('.group').on('click', function (event) {
    $(event.target).next('.ingredients').slideToggle();
  });

  $('#let-there-be-drinks').on('click', function () {
    iDesign.concoct();
  });
});
