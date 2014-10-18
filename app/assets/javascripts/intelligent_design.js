// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function IntelligentDesign() {}

IntelligentDesign.prototype.concoct = function() {
    var selectedIngredients = $('input:checked');
    var pageContext = this;
    $.ajax({
        url: "/godmode",
        type: "POST",
        data: { ingredients : _.map(selectedIngredients, function(ing) { return $(ing).val() }) },
        dataType: "json",
        success: function (data) {
            pageContext.showDrinks(data);
        },
        error: function (jqXHR, textStatus, errorThrown) { console.log(errorThrown) }
    });
}

IntelligentDesign.prototype.showDrinks = function(drinks) {
    console.log(drinks);
}

$(function() {

    var iDesign = new IntelligentDesign();

    $('.button').click(function() {
        iDesign.concoct();
    })
});