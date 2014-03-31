$(document).ready(function () {
    var url = $('.wait').length>0?$('.wait').first().data('url'):null;
    if (!url) return;
    $.ajax(url).done(function (data) {
        $('#table-contents').html(data);
        $('.preloader, .overlay').hide();
    })
})