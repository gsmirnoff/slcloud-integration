$(document).ready(function () {
    var url = $('.wait').length > 0 ? $('.wait').first().data('url') : null;
    if (!url) return;
    var elem = $('.wait').first();
    var data = {
        party_id: elem.data('partyid'),
        opp_id: elem.data('oppid'),
        key_contact: elem.data('con')
    };
    for (var key in data) {
        if (!data[key]) delete data[key];
    }
    $.ajax(url, {data: data}).done(function (data) {
        $('#table-contents').html(data);
        $('.preloader, .overlay').hide();
    })
})