// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function Evolution() {
  this.selectedBase     = null;
  this.evolvedCocktails = null;
};

Evolution.prototype.evolve = function() {
  var key, data, selectedBase, success, error;

  selectedBase = $('.selected-drink').length ? $('.selected-drink').attr('value') : $('.selected').attr('value');
  key          = $('.selected-drink').length ? 'cocktail' : 'base'
  data         = {};
  data[key]    = selectedBase;

  success = function (data) {
    var $alert = $('.alert-success');

    if (data.drinks.length === 0) {
      $alert.children('h4').text('You have reach the highest evolution!');
      $alert.children('p').text('Congradulations on becoming the dominant drink in your species!.');
      $alert.removeClass('hidden');
    } else {
      this.showDrinks(data);
      $('#natural-selection').addClass('disabled');
      $('.alert').addClass('hidden');
    }
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
    url: '/darwin',
    type: 'POST',
    data: data,
    dataType: 'json',
    success: success,
    error: error
  });
};

Evolution.prototype.showDrinks = function (drinks) {
  $('#drinks').html(drinks.html);

  // Toggles visibility of drink details.
  $('.drink').on('click', function (event) {
    $(event.target).next('.drink-info').slideToggle('fast');
  });

  $('.evolved-drink').on('click', function () {
    $('.selected-drink').removeClass('selected-drink');
    $(this).addClass('selected-drink');
    $('#natural-selection').removeClass('disabled');
  });

  // $('#again').on('click', function (event) {
//     event.preventDefault();
//
//     $('#selection').show();
//     $('html, body').animate({
//       scrollTop: 0
//     }, function () {
//       $('input[type="checkbox"]').attr('checked', false);
//       $('#drinks').empty();
//     });
//   });
};

$(document).on('ready page:load', function () {
  var evolve = new Evolution();

  $('#natural-selection').on('click', function (event) {
    event.preventDefault();

    if (!$(this).hasClass('disabled')) {
      evolve.evolve();
    }
  });

  $('.evolution').on('click', function (event) {
    event.preventDefault();

    $('.selected').removeClass('selected');
    $(this).addClass('selected');
  });
});
