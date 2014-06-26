function flash(type, message) {
    var count = parseInt($('#flash-counter').html()); 
    if(count == 0) {
        $('#flash-placeholder').hide();
    }
    $('#flash-menu').append('<li><div class="alert alert-' + type + '">' + message + '<div></li>');
    count += 1;
    $('#flash-counter').html(count);
    $('#flash-link').addClass('active')
    $('#flash-link').effect('shake', {distance: 10});
}

function updateFlashCount() {
    count = parseInt($('#flash-menu .alert').length);
    $('#flash-counter').html(count);
    if(count == 0) {
        $('#flash-placeholder').show();
    }
}
