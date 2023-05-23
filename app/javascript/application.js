// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"
import "./jquery_ui"
import "popper"
import "bootstrap"

function scrollBottom() {
  if ($('#messages').length > 0) {
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

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

$(document).on('turbo:load', function() {
    $('#InputPublications').click(function() {
        $('#modalPublication').modal('show');
      });
});

$(document).on('turbo:load', function() {
  $('body').on('click', '#add-like', function() {
      let publicationId = $(this).data("publication-id");
      let buttonLike = $(this)
      $.ajax({
        url: "/publications/"+publicationId+"/likes",
        type: "POST",
        data: {
          id: publicationId,
        },
        success: function(data) {
          buttonLike.removeClass("btn-secondary");
          buttonLike.addClass("btn-primary");
          
          buttonLike.attr('id', 'deleted-like')

          let likesCount = parseInt($("#likes-count"+publicationId).attr("data-likes"));
          $("#likes-count"+publicationId).attr("data-likes", likesCount + 1);
          $("#likes-count"+publicationId).text(likesCount + 1);
        }
      });
    });
});

$(document).on('turbo:load', function() {
    $('body').on('click', '#deleted-like', function() {
        let publicationId = $(this).data("publication-id");
        let buttonLike = $(this)
        
        console.log($(this))
        $.ajax({
          url: "/publications/"+publicationId+"/likes",
          type: "PUT",
          data: {
            id: publicationId,
          },
          success: function(data) {
            if(data.add){
              buttonLike.removeClass("btn-secondary");
              buttonLike.addClass("btn-primary");
            } else {
              buttonLike.removeClass("btn-primary");
              buttonLike.addClass("btn-secondary");
            }
            console.log(data)
            $("#likes-count"+publicationId).attr("data-likes", data.likesCount);
            $("#likes-count"+publicationId).text(data.likesCount);
          }
        });
      });
});

$(document).on('turbo:load', function() {
  $('body').on('click', '#buttonEditar', function() {
      $('#descriptionText').removeClass('d-flex')
      $('#descriptionText').addClass('d-none')
      $('#bottonEditar').removeClass('d-flex')
      $('#bottonEditar').addClass('d-none')
      $('#textAreaDescription').removeClass('d-none')
      $('#textAreaDescription').removeClass('d-block')
  });
});

$(document).on('turbo:load', function() {
  $('body').on('click', '#buttonUpdateDescription', function() {
      $("#descriptionShow").text($('#description').val());
      $('#descriptionText').addClass('d-flex')
      $('#descriptionText').removeClass('d-none')
      $('#bottonEditar').addClass('d-flex')
      $('#bottonEditar').removeClass('d-none')
      $('#textAreaDescription').addClass('d-none')
      $('#textAreaDescription').removeClass('d-block')
  });
});

$(document).on('turbo:load', function() {
  $('body').on('click', '#botonShareCreate', function() {
    let modalId = $(this).attr('dataId');
    $('#' + modalId).modal('hide');
  });
});

$(document).on('turbo:load', function() {
  let all_message = document.getElementById("all-messages");
  if (all_message){
    all_message.scrollTop = all_message.scrollHeight;
    scrollBottom();
  }
});

$(document).on('turbo:load', function() {
  $('body').on('click', '#load_more_publication', function() {
    $.ajax({
      url: '/publications/load_more',
      method: 'GET',
      data: { page: 10 },
      success: function(response) {
        // Manejar la respuesta y mostrar los registros adicionales en la página
      },
      error: function() {
        // Manejar el error si la solicitud no tiene éxito
      }
    });
  });
});

import "./channels"
window.scrollBottom = scrollBottom;