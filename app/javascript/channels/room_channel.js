import consumer from "./consumer"

$(document).on("turbolinks:load", function() {
  const chatChannel = consumer.subscriptions.create({ channel: "RoomChannel", room: $("#words").data("room_id") }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received: function(data) {
      return $("#words").append(data["word"]);
    },

    speak: function(word) {
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
