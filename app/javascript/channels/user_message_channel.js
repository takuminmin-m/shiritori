import consumer from "./consumer"

$(document).on("turbolinks:load", function() {
  const chatChannel = consumer.subscriptions.create({ channel: "UserMessageChannel", user: $("#user_id").data("user_id") }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      alert(`${data["message"]}`);
    }
  });
});
