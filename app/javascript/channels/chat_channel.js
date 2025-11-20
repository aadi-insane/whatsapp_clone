import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const messagesContainer = document.getElementById("messages");
  if (messagesContainer) {
    const chatId = messagesContainer.dataset.chatId;

    consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(`Connected to ChatChannel for chat ID: ${chatId}`);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
        console.log(`Disconnected from ChatChannel for chat ID: ${chatId}`);
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        console.log("Received data:", data);
      }
    });
  }
});
