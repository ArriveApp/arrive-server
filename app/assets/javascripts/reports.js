$(document).on("ready page:load", function () {
    $('*[data-ui="datepicker"]').datepicker();

    $('time').each(function () {
        var tag = $(this);
        var datetime = tag.attr('datetime');
        var format = tag.data('format');

        var date = new Date(datetime);
        tag.html(moment(date).format(format));
    });
});
