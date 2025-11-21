import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static values = { chatId: Number, currentUserId: Number }

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
    // Don't append a duplicate message, which the sender receives via Turbo Streams.
    if (document.getElementById(`message-${data.message_id}`)) {
      this.scrollToBottom()
      return
    }

    let html = data.html
    // On the receiver's end, swap the "sent" class for a "received" class
    if (data.sender_id !== this.currentUserIdValue) {
      html = html.replace("whatsapp-message-sent", "whatsapp-message-received")
    }

    this.element.insertAdjacentHTML("beforeend", html)
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}
