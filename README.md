# 📱 WhatsApp Clone: Real-time Messaging Application

## Table of Contents

*   ✨ [Introduction](#introduction)
*   🚀 [Features](#features)
*   🛠️ [Technologies Used](#technologies-used)
*   ▶️ [Getting Started](#getting-started)
    *   ✅ [Prerequisites](#prerequisites)
    *   ⬇️ [Installation](#installation)
    *   🗄️ [Database Setup](#database-setup)
    *   ▶️ [Running the Application](#running-the-application)
*   📂 [Project Structure](#project-structure)
*   💡 [Core Functionalities Explained](#core-functionalities-explained)
    *   🔐 [User Authentication & Profiles](#user-authentication--profiles)
    *   ⚡ [Real-time Chat with ActionCable & Turbo Streams](#real-time-chat-with-actioncable--turbo-streams)
    *   🎨 [Styling & User Interface](#styling--user-interface)
*   📊 [Database Schema](#database-schema)
*   🌟 [Future Enhancements](#future-enhancements)
*   🤝 [Contributing](#contributing)
*   📜 [License](#license)
*   🙋‍♂️ [Contact](#contact)

## Introduction

👋 Welcome to the **WhatsApp Clone** project! This is a modern, real-time messaging application built with Ruby on Rails, designed to mimic the core functionalities and user experience of the popular WhatsApp platform. It leverages the power of ActionCable for WebSocket-driven real-time communication ⚡ and Turbo Streams for efficient UI updates, providing a seamless and interactive chat experience.

This project serves as a comprehensive example of building a full-stack web application with Rails, incorporating best practices for user authentication, data management, and real-time features. Whether you're looking to understand how to implement live chat 💬, manage user profiles 👤, or simply explore a well-structured Rails application, this repository offers a valuable resource.

## Features

🚀 Our WhatsApp Clone comes packed with essential messaging features, ensuring a robust and engaging user experience:

*   🔐 **User Authentication:** Secure user registration and login powered by Devise.
*   👤 **User Profiles:** Users can create and manage their profiles, including a bio and an avatar.
*   💬 **One-on-One Chats:** Initiate and participate in private conversations with other users.
*   ⚡ **Real-time Messaging:** Send and receive messages instantly without page reloads, thanks to ActionCable WebSockets.
*   🔄 **Dynamic UI Updates:** Seamless UI updates for new messages and chat interactions using Turbo Streams.
*   📝 **Chat List:** A dynamic list displaying all active chats for the logged-in user.
*   📱 **Responsive Design:** A clean and intuitive user interface inspired by WhatsApp, built with Bootstrap and custom CSS, ensuring a pleasant experience across various devices.
*   💾 **Message Persistence:** All messages are stored in a PostgreSQL database, ensuring chat history is preserved.

## Technologies Used

🛠️ This project is a testament to the versatility and power of the Ruby on Rails ecosystem. Here's a breakdown of the key technologies employed:

*   💎 **Ruby on Rails (7.x):** The robust web application framework providing the backend structure, MVC architecture, and RESTful APIs.
*   🔴 **Ruby (3.x):** The programming language powering the Rails application.
*   🐘 **PostgreSQL:** A powerful, open-source relational database system used for data storage.
*   🔌 **ActionCable:** Rails' integrated WebSocket framework, enabling real-time communication between the server and clients for live chat functionality.
*   🚀 **Turbo (Hotwire):** A set of techniques for building fast, modern web applications without writing much JavaScript. Specifically, **Turbo Streams** are used for sending HTML fragments over WebSockets to update parts of the page in real-time.
*   💡 **Stimulus.js:** A modest JavaScript framework that complements Turbo by adding just enough behavior to your HTML. Used for enhancing UI interactivity.
*   🛡️ **Devise:** A flexible authentication solution for Rails, handling user registration, login, and session management.
*   🎨 **Bootstrap (5.x):** A popular CSS framework for developing responsive and mobile-first websites, used for foundational styling and UI components.
*   🖌️ **Custom CSS:** Tailored stylesheets (`custom.css`) to achieve the distinct WhatsApp-like aesthetic and fine-tune the user interface.
*   🖼️ **ImageMagick (via Active Storage):** For processing and managing user avatars.

## Getting Started

▶️ Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

✅ Before you begin, ensure you have the following installed:

*   **Ruby:** Version 3.x (check `.ruby-version` for exact version, e.g., `rbenv install 3.x.x` or `rvm install 3.x.x`).
*   **Bundler:** `gem install bundler`
*   **PostgreSQL:** Ensure the PostgreSQL server is running on your system.
*   **Node.js & Yarn:** Required for JavaScript dependencies.
*   **ImageMagick:** For Active Storage image processing. On Ubuntu/Debian: `sudo apt-get install imagemagick`. On macOS: `brew install imagemagick`.

### Installation

⬇️

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/whatsapp_clone.git
    cd whatsapp_clone
    ```
    *(Replace `https://github.com/your-username/whatsapp_clone.git` with the actual repository URL)*

2.  **Install Ruby dependencies:**
    ```bash
    bundle install
    ```

3.  **Install JavaScript dependencies:**
    ```bash
    yarn install
    ```

### Database Setup

🗄️

1.  **Create the database:**
    ```bash
    rails db:create
    ```

2.  **Run migrations:**
    ```bash
    rails db:migrate
    ```

3.  **Seed the database (optional, for demo data):**
    ```bash
    rails db:seed
    ```
    *(This will create some sample users, profiles, and chats to help you get started quickly.)*

### Running the Application

▶️

1.  **Start the Rails server:**
    ```bash
    rails s
    ```

2.  **Open your browser:**
    Navigate to `http://localhost:3000`.

You should now see the WhatsApp Clone application running! Register a new user or log in with seeded credentials to start exploring. 🚀

## Project Structure

📂 The application follows the standard Ruby on Rails MVC (Model-View-Controller) architecture. Here's a high-level overview of the key directories and their roles:

*   `app/channels/`: 🔌 Contains ActionCable channel definitions (`chat_channel.rb`) for real-time communication.
*   `app/controllers/`: 🚦 Houses the application's controllers (`chats_controller.rb`, `messages_controller.rb`, `profiles_controller.rb`, etc.) that handle incoming requests and manage data flow.
*   `app/javascript/`: 💡 Frontend JavaScript, including Stimulus controllers (`chat_subscription_controller.js`) and ActionCable consumer setup (`chat_channel.js`).
*   `app/models/`: 🗃️ Defines the application's data models (`user.rb`, `profile.rb`, `chat.rb`, `message.rb`, `chat_membership.rb`) and their relationships.
*   `app/views/`: 🖼️ Contains ERB templates for rendering HTML pages and partials (`chats/`, `messages/`, `profiles/`).
*   `app/assets/stylesheets/`: 🎨 Custom CSS (`custom.css`) and other stylesheets.
*   `config/`: ⚙️ Configuration files for the Rails application, routes (`routes.rb`), and environment settings.
*   `db/migrate/`: ⬆️ Database migration files for schema management.

## Core Functionalities Explained

💡

### User Authentication & Profiles

🔐

*   **Devise Integration:** User authentication is handled seamlessly by the Devise gem. This provides robust features like user registration, login, logout, and password management.
*   **Profile Management:** Each user has an associated `Profile` model, allowing them to customize their public information, such as a bio and an avatar. Active Storage is used for efficient and scalable avatar uploads. 🖼️

### Real-time Chat with ActionCable & Turbo Streams

⚡ This is the heart of the WhatsApp Clone, enabling instant messaging.

1.  **ActionCable Channels (`app/channels/chat_channel.rb`):** 🔌
    *   When a user subscribes to a chat (e.g., by visiting a chat page), their client subscribes to a specific `ChatChannel` instance, identified by a `chat_id`.
    *   The `stream_from "chat_#{params[:chat_id]}"` line in `chat_channel.rb` tells ActionCable to broadcast any messages sent to this stream to all connected subscribers.

2.  **Message Creation (`app/controllers/messages_controller.rb`):** ✍️
    *   When a user sends a message, it's handled by the `MessagesController#create` action.
    *   After saving the message to the database, two key actions occur:
        *   **ActionCable Broadcast:** `ActionCable.server.broadcast("chat_#{@chat.id}", { ... })` sends the new message data (content, sender email, message ID) to all clients subscribed to that specific chat channel. This ensures other users in the chat receive the message in real-time. 📡
        *   **Turbo Stream Response:** The controller responds with `format.turbo_stream`. This triggers the rendering of `app/views/messages/create.turbo_stream.erb`. 🚀

3.  **Turbo Stream Updates (`app/views/messages/create.turbo_stream.erb`):** 🔄
    *   This ERB template generates a `turbo-stream` HTML response.
    *   `<turbo-stream action="append" target="messages">` instructs Turbo to append the rendered message partial (`_message.html.erb`) to the HTML element with `id="messages"` on the client-side. This provides an immediate UI update for the sender without a full page reload.

4.  **Client-side Handling (`app/javascript/channels/chat_channel.js`):** 💻
    *   The `chat_channel.js` file establishes the ActionCable connection and subscribes to the `ChatChannel`.
    *   The `received(data)` callback is invoked when new data is broadcasted via ActionCable. While this project primarily uses Turbo Streams for DOM updates, the `received` callback can be used for other real-time interactions (e.g., displaying typing indicators, notifications, or handling messages from other users if Turbo Streams aren't used for their display).
    *   **Important Note:** To prevent duplicate messages, the client-side JavaScript *does not* manually append messages to the DOM when `received` is called. Instead, the `turbo-stream` response from the server handles the DOM manipulation for the sending user, and other users receive the message via ActionCable, which can then be handled by their `chat_channel.js` (though in this setup, other users would also receive the `turbo-stream` if they are on the same chat page). The primary goal is to ensure each message appears only once. ✅

### Styling & User Interface

🎨 The application's visual appeal and user experience are crafted with a blend of Bootstrap and custom CSS:

*   **Bootstrap 5:** Provides a solid foundation for responsive layouts, navigation, forms, and various UI components, ensuring cross-device compatibility. 📱
*   **Custom CSS (`app/assets/stylesheets/custom.css`):** This stylesheet is meticulously designed to replicate the familiar look and feel of WhatsApp. It defines custom colors (using CSS variables), message bubble styles, chat list layouts, and other specific UI elements to create an authentic messaging application aesthetic. 🖌️
*   **Profile Avatars:** User avatars are displayed prominently in chat lists and profiles, enhancing personalization. 🖼️

## Database Schema

📊 The application's data is structured across several key models:

*   **`User` (via Devise):** 👤
    *   `email`: string (unique)
    *   `encrypted_password`: string
    *   `reset_password_token`: string
    *   `reset_password_sent_at`: datetime
    *   `remember_created_at`: datetime
    *   `updated_at`: datetime
    *   *Associations:* `has_one :profile`, `has_many :messages`, `has_many :chat_memberships`, `has_many :chats, through: :chat_memberships`

*   **`Profile`:** 📝
    *   `user_id`: integer (foreign key to `users`)
    *   `bio`: text
    *   `created_at`: datetime
    *   `updated_at`: datetime
    *   *Active Storage:* `has_one_attached :avatar` for user profile pictures.
    *   *Associations:* `belongs_to :user`

*   **`Chat`:** 💬
    *   `created_at`: datetime
    *   `updated_at`: datetime
    *   *Associations:* `has_many :messages`, `has_many :chat_memberships`, `has_many :users, through: :chat_memberships`

*   **`Message`:** ✉️
    *   `chat_id`: integer (foreign key to `chats`)
    *   `user_id`: integer (foreign key to `users`)
    *   `content`: text
    *   `created_at`: datetime
    *   `updated_at`: datetime
    *   *Associations:* `belongs_to :chat`, `belongs_to :user`

*   **`ChatMembership`:** 👥
    *   `chat_id`: integer (foreign key to `chats`)
    *   `user_id`: integer (foreign key to `users`)
    *   `created_at`: datetime
    *   `updated_at`: datetime
    *   *Associations:* `belongs_to :chat`, `belongs_to :user`
    *   *Purpose:* This is a join table for the many-to-many relationship between `User` and `Chat`, allowing multiple users to be part of a single chat.

## Future Enhancements

🌟 This project provides a solid foundation for a real-time messaging application. Here are some ideas for future enhancements:

*   **Group Chats:** 👨‍👩‍👧‍👦 Extend the current one-on-one chat functionality to support multiple participants in a single conversation.
*   **Message Status:** ✅✅✅ Implement "sent," "delivered," and "read" receipts for messages.
*   **Typing Indicators:** ✍️... Show when another user is actively typing a message.
*   **Emoji Support:** 😂 Integrate an emoji picker for richer message content.
*   **Media Sharing:** 📸 Allow users to send images, videos, and other file types.
*   **Push Notifications:** 🔔 Implement browser or mobile push notifications for new messages.
*   **Search Functionality:** 🔍 Enable searching through chat messages or contacts.
*   **Online Status:** 🟢 Display the online/offline status of users.
*   **Message Editing/Deletion:** ✏️🗑️ Add functionality to edit or delete sent messages.
*   **User Blocking:** 🚫 Allow users to block unwanted contacts.

## Contributing

🤝 Contributions are welcome! If you have suggestions for improvements, new features, or bug fixes, please follow these steps:

1.  Fork the repository. 🍴
2.  Create a new branch (`git checkout -b feature/your-feature-name`). 🌿
3.  Make your changes. 💻
4.  Commit your changes (`git commit -m 'Add some feature'`). 💾
5.  Push to the branch (`git push origin feature/your-feature-name`). ⬆️
6.  Open a Pull Request. 📥

Please ensure your code adheres to the existing style and conventions.

## License

📜 This project is open-source and available under the [MIT License](LICENSE.md).

## 🙋‍♂️ Contact

**Aditya Aerpule**
Trainee Developer @ Shriffle Technologies
📧 [[adityaaerpule@gmail.com](mailto:adityaaerpule@gmail.com)]
🔗 [GitHub](https://github.com/aadi-insane) | [LinkedIn](https://www.linkedin.com/in/aditya-aerpule-a22062309/)

---
