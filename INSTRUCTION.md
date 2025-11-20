# WhatsApp Clone Rails Project - Roadmap

This roadmap provides a **step-by-step guide** for building the WhatsApp clone from scratch, using **Rails 7**, **Bootstrap CDN**, and **custom CSS**.

---

## 1. Project Initialization

1. Create a new Rails project:

   ```bash
   rails new whatsapp_clone --database=postgresql
   cd whatsapp_clone
   ```
2. Initialize Git repository:

   ```bash
   git init
   git add .
   git commit -m "Initial commit: Rails project setup"
   ```
3. Configure your database (`config/database.yml`) and run:

   ```bash
   rails db:create
   ```

---

## 2. Set Up User Authentication

1. Add `devise` gem for authentication:

   ```ruby
   # Gemfile
   gem 'devise'
   ```
2. Install and configure Devise:

   ```bash
   bundle install
   rails generate devise:install
   rails generate devise User
   rails db:migrate
   ```
3. Set root route to the chat page after login:

   ```ruby
   # config/routes.rb
   root to: "chats#index"
   ```
4. Add authentication checks in controllers:

   ```ruby
   before_action :authenticate_user!
   ```

---

## 3. Create Models & Database Structure

1. Create a **Chat model** for chat rooms:

   ```bash
   rails g model Chat name:string
   ```

2. Create a **Message model**:

   ```bash
   rails g model Message content:text user:references chat:references
   ```

3. Create a **Profile model** belonging to a User:

   ```bash
   rails g model Profile user:references profile_picture:string name:string bio:text
   ```

4. Create a **ChatMembership join model** for a many-to-many relationship between users and chats. This is a more robust approach, allowing users to be members of a chat without having to send a message first.

   ```bash
   rails g model ChatMembership user:references chat:references
   ```

5. Run all migrations:

   ```bash
   rails db:migrate
   ```

6. Set up associations:

   ```ruby
   # app/models/user.rb
   has_one :profile, dependent: :destroy
   has_many :messages
   has_many :chat_memberships
   has_many :chats, through: :chat_memberships

   # app/models/profile.rb
   belongs_to :user

   # app/models/chat.rb
   has_many :messages, dependent: :destroy
   has_many :chat_memberships, dependent: :destroy
   has_many :users, through: :chat_memberships

   # app/models/message.rb
   belongs_to :user
   belongs_to :chat

   # app/models/chat_membership.rb
   belongs_to :user
   belongs_to :chat
   ```

---

## 4. Set Up Routes & Controllers

1. Create `ChatsController` and `MessagesController`:

   ```bash
   rails g controller Chats index show
   rails g controller Messages create
   ```
2. Configure routes:

   ```ruby
   resources :chats, only: [:index, :show] do
     resources :messages, only: [:create]
   end
   ```

---

## 5. Frontend Styling

1. Add **Bootstrap CDN** in `application.html.erb`:

   ```html
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
   <%= stylesheet_link_tag "custom", media: "all" %>
   ```
2. Create `app/assets/stylesheets/custom.css` for custom styles:

   ```css
   .chat-container { max-width: 600px; margin: 0 auto; }
   .message { padding: 10px; border-radius: 8px; margin-bottom: 10px; }
   ```
3. Design **chat UI**: list of chats, chat messages, input form.

---

## 6. Implement Messaging

1. Add **message form** in `chats/show.html.erb`:

   ```erb
   <%= form_with(model: [ @chat, Message.new ], local: true) do |f| %>
     <%= f.text_area :content, class: "form-control" %>
     <%= f.submit "Send", class: "btn btn-primary mt-2" %>
   <% end %>
   ```
2. Implement `MessagesController#create` to save messages.
3. Display messages in `chats/show.html.erb`:

   ```erb
   <div class="messages">
     <% @chat.messages.each do |msg| %>
       <div class="message"><strong><%= msg.user.email %>:</strong> <%= msg.content %></div>
     <% end %>
   </div>
   ```

---

## 7. Add Real-Time Messaging with Action Cable

1. Generate an Action Cable channel for chats:

   ```bash
   rails generate channel Chat
   ```
2. Configure `app/channels/chat_channel.rb`:

   ```ruby
   class ChatChannel < ApplicationCable::Channel
     def subscribed
       stream_from "chat_#{params[:chat_id]}"
     end

     def unsubscribed
       # Any cleanup needed when channel is unsubscribed
     end
   end
   ```
3. Modify `Message` model (`app/models/message.rb`) to broadcast after creation:

   ```ruby
   class Message < ApplicationRecord
     belongs_to :user
     belongs_to :chat

     after_create_commit { broadcast_message }

     private

     def broadcast_message
       ActionCable.server.broadcast("chat_#{self.chat.id}", {
         message: self.content,
         user_email: self.user.email
       })
     end
   end
   ```
4. Update `MessagesController#create` (`app/controllers/messages_controller.rb`) to ensure message creation triggers the broadcast. (No explicit change needed here if `after_create_commit` is used).

5. Update `chats/show.html.erb` to subscribe to the channel and display new messages:

   ```erb
   <div class="messages" data-controller="chat" data-chat-id="<%= @chat.id %>">
     <% @chat.messages.each do |msg| %>
       <div class="message"><strong><%= msg.user.email %>:</strong> <%= msg.content %></div>
     <% end %>
   </div>

   <%= form_with(model: [ @chat, Message.new ], local: false, data: { controller: "reset-form", action: "turbo:submit-end->reset-form#reset" }) do |f| %>
     <%= f.text_area :content, class: "form-control", required: true %>
     <%= f.submit "Send", class: "btn btn-primary mt-2" %>
   <% end %>

   <script type="module">
     import consumer from "../../channels/consumer"

     document.addEventListener('turbo:load', () => {
       const messagesContainer = document.querySelector('.messages');
       if (messagesContainer) {
         const chatId = messagesContainer.dataset.chatId;

         consumer.subscriptions.create({ channel: "ChatChannel", chat_id: chatId }, {
           received(data) {
             const messageElement = `<div class="message"><strong>${data.user_email}:</strong> ${data.message}</div>`;
             messagesContainer.insertAdjacentHTML('beforeend', messageElement);
             messagesContainer.scrollTop = messagesContainer.scrollHeight;
           }
         });
         messagesContainer.scrollTop = messagesContainer.scrollHeight;
       }
     });
   </script>
   ```
   *Note: You might need to create a `reset_form_controller.js` for the `reset-form` Stimulus controller if you use it.*

---

## 8. Extra Features

* **User avatars** using ActiveStorage
* **Group chats**
* **Search users and chats**
* **Notifications for new messages**

---

## 9. Testing & Debugging

1. Use Rails console for testing:

   ```bash
   rails console
   ```
2. Check logs for errors:

   ```bash
   tail -f log/development.log
   ```
3. Ensure database migrations are up-to-date:

   ```bash
   rails db:migrate:status
   ```

---

## 10. Deployment

1. Precompile assets for production:

   ```bash
   rails assets:precompile
   ```
2. Use PostgreSQL on production.
3. Set environment variables for secrets.

---

