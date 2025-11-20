// app/javascript/controllers/chat_subscription_controller.js

import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatId: Number, currentUserEmail: String }

  connect() {
    this.subscription = consumer.subscriptions.create(
      { channel: "ChatChannel", chat_id: this.chatIdValue },
      {
        received: this.receive.bind(this),
      }
    )
    this.scrollToBottom()
  }

  disconnect() {
    this.subscription.unsubscribe()
  }

  receive(data) {
    // console.log(data)
    if (document.getElementById(`message-${data.message_id}`)) {
      return;
    }

    const isCurrentUser = data.user_email === this.currentUserEmailValue
    const messageClass = isCurrentUser ? "whatsapp-message-sent" : "whatsapp-message-received"

    const senderHtml = isCurrentUser
      ? ""
      : `<small class="whatsapp-message-sender">${data.user_name}</small>`

    const messageElement = `
      <div class="whatsapp-message ${messageClass}" id="message-${data.message_id}">
        <div class="whatsapp-message-content">
          ${senderHtml}
          <p class="mb-0">${data.message}</p>
          <small class="whatsapp-message-timestamp">
            ${new Date().toLocaleTimeString([], {
              hour: "2-digit",
              minute: "2-digit",
            })}
          </small>
        </div>
      </div>`

    this.element.insertAdjacentHTML("beforeend", messageElement)
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
