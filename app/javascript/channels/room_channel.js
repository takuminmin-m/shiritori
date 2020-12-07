import consumer from "./consumer"

$(document).on("turbolinks:load", function() {
  const element = document.querySelector("#words");
  const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: $("#words").data("room_id") }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      const received_element = document.createElement("div");
      received_element.className = "word";
      received_element.innerHTML = `
        <p>
        ${data["user_name"]}: ${data["content"]}
        </p>
      `;

      element.appendChild(received_element);
    },

    speak(word) {
      return this.perform('speak', {
        word: word
      });
    }
  });


  $(document).on("keypress", "[data-behavior~=room_speaker]", function(event) {
    if (event.keyCode === 13) {
      chatChannel.speak(event.target.value);
      event.target.value = "";
      return event.preventDefault();
    };
  });
});
