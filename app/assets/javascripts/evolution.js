// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function Evolution() {
    this.selectedBase = null;
    this.evolvedCocktails = null;
}

Evolution.prototype.evolve = function() {
    var selectedBase = $.map($('input:checked'), function (base) { return $(base).val(); }),
        pageContext         = this;

    $.ajax({
        url: '/darwin',
        type: 'POST',
        data: { base: selectedBase },
        dataType: 'json',
        success: function (data) {
            console.log(data);
            this.evolvedCocktails = data;
        },
        error: function (jqXHR, textStatus, errorThrown) { throw new Error(errorThrown); }
    });
}

$(function() {
    var evolve = new Evolution();

    $('#natural-selection').on('click', function () {
        evolve.evolve();
    });

    // $('input:checkbox').change(function() {
//         var checked = this;
//         $('input:checkbox').each( function( index, element ) {
//             if(element === checked) return;
//
//             $(element).attr('checked', false);
//         });
//     });
});
