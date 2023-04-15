// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"
import "./jquery_ui"
import "popper"
import "bootstrap"

$(document).on("ajax:success", "#edit_user_form", function(event) {
    $("#editModal").modal("hide"); // cierra el modal
    location.reload(); // recarga la página
});

$(document).on('turbo:load', function() {
    $('.imagenPortada').click(function () {
        let image_picture_id = $(this).attr('id');
        console.log(image_picture_id);
        $('input#portada_picture_id').val(image_picture_id);
        $('li').removeClass('selected');
        $(this).addClass('selected')
    });
});