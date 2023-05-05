import consumer from "channels/consumer"

consumer.subscriptions.create("ChatfriendChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    //Obtiene url de la pagina
    let url = window.location.href;
    //Obtiene el ultimo dato despues del /
    const lastPart = parseInt((url.split("/").pop()).trim());
    //Obtiene el elemento div donde se agregara el mensaje
    let chat_messages = document.getElementById("chat-messages");
    //Crea el string con la etiqueta imagen y la url
    let image = '<img src="'+data.image_url+'" class="profile-image-icon"/>'
    //Valida si el id del usuario que envio el mensaje es diferente al id del chat en el que esta
    if(parseInt(data.sender.id) !== lastPart ){
      //Agrega los elementos con el mensaje e imagen del usuario que lo envia
      chat_messages.innerHTML += `
      <div class="media mb-3 d-flex justify-content-end align-items-center">
          <div class="media-body mx-4">
              <p class="mb-0">${data.body}</p>
          </div>
          ${ data.image_url != 'no-image' ? image: '<i class="fa fa-user fa-2x mx-2"></i>'}
      </div>`;

      const messageInput = document.getElementById('messages-input-'+lastPart);
      messageInput.value = '';
    }else {
      //Agrega los elementos con el mensaje e imagen del usuario que lo recibe
      chat_messages.innerHTML += `
      <div class="media mb-3 d-flex justify-content-start align-items-center">
      ${ data.image_url != 'no-image' ? image: '<i class="fa fa-user fa-2x mx-2"></i>'}
          <div class="media-body mx-4">
              <p class="mb-0">${data.body}</p>
          </div>
          
      </div>`;
    }
    
    let all_message = document.getElementById("all-messages");
    all_message.scrollTop = all_message.scrollHeight;
    scrollBottom();
  }
});