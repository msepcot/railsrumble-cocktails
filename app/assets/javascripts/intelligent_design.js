// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function IntelligentDesign() {}

IntelligentDesign.prototype.concoct = function () {
  var selectedIngredients = $('input:checked'),
      pageContext         = this;

  $.ajax({
    url: '/godmode',
    type: 'POST',
    data: { ingredients : $.map(selectedIngredients, function (ing) { return $(ing).val(); }) },
    dataType: 'json',
    success: function (data) { pageContext.showDrinks(data); },
    error: function (jqXHR, textStatus, errorThrown) { throw new Error(errorThrown); }
  });
}

IntelligentDesign.prototype.showDrinks = function (drinks) {
  $('#drinks').html(drinks.html);
};

$(function () {
  var iDesign = new IntelligentDesign();

  $('#let-there-be-drinks').on('click', function () {
      iDesign.concoct();
  });
});
