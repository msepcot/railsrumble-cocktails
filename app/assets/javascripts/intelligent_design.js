// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function IntelligentDesign() {}

IntelligentDesign.prototype.concoct = function () {
  var ingredients, success, error;

  ingredients = $.map($('input:checked'), function (checkbox) {
    return $(checkbox).val();
  });

  success = function (data) {
    if (data.drinks.length === 0) {
      error(undefined, undefined, { message: 'There were no drinks found for your selected ingredients.' });
    }

    this.showDrinks(data);
    $('.alert').addClass('hidden');
  }.bind(this);

  error = function (jqXHR, textStatus, errorThrown) {
    var $alert = $('.alert');

    $alert.children('h4').text('There was an error!');
    $alert.children('p').text(errorThrown.message);
    $alert.removeClass('hidden');

    $('html, body').animate({ scrollTop: 0 });

    throw new Error(errorThrown);
  };

  $.ajax({
    url: '/godmode',
    type: 'POST',
    data: { ingredients: ingredients },
    dataType: 'json',
    success: success,
    error: error
  });
}

IntelligentDesign.prototype.showDrinks = function (drinks) {
  $('#drinks').html(drinks.html);
  $('#selection').slideUp('fast');

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

$(document).on('ready page:load', function () {
  var iDesign = new IntelligentDesign();

  $('.group').on('click', function (event) {
    $(event.target).next('.ingredients').slideToggle('fast');
  });

  $('#let-there-be-drinks').on('click', function () {
    iDesign.concoct();
  });
});
