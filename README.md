# Chat-PoC (Proof of Concept)

## 📝 Description

**Chat-PoC** is a proof of concept for a real-time chat module enabling instant communication between a customer and a support agent.
This project was developed  to demonstrate the technical feasibility and simplicity of implementing real-time chat using Angular and Spring Boot.

* **Backend:** Spring Boot (WebSocket, STOMP, SockJS, Lombok)
* **Frontend:** Angular, RxStomp, PrimeNG (for UI)
* **No database or authentication: focus is exclusively on the chat feature**

---

## 🚀 Installation

### 1️⃣ Clone the repository

```bash
git clone https://github.com/maximedrouault/poc-chat.git
cd poc-chat
```

### 2️⃣ Prerequisites

* **Java 21+**
* **Maven 3.9+**
* **Node.js 20+**
* **Angular CLI 17+**
* **npm**

---

### 3️⃣ Start the backend

```bash
cd backend
mvn spring-boot:run
```

* The backend will be available at **[http://localhost:8080](http://localhost:8080)**

---

### 4️⃣ Start the frontend

```bash
cd frontend
npm install
ng serve
```

* The frontend will be accessible at **[http://localhost:4200](http://localhost:4200)**

---

## 💬 Usage

* Open **two browser windows**:

    * One at **/customer** ([http://localhost:4200/customer](http://localhost:4200/customer))
    * One at **/support** ([http://localhost:4200/support](http://localhost:4200/support))
* Send a message in either interface: it will appear in real time on both screens, with the “role” (`customer` or `support`) clearly identified.

---

## 📦 Tech Stack

* **Backend**

    * Spring Boot (WebSocket, STOMP, SockJS)
    * Lombok
* **Frontend**

    * Angular 17+
    * @stomp/rx-stomp + sockjs-client (WebSocket STOMP)
    * PrimeNG 20 (for UI)
    * RxJS

---

## 🗂️ Project structure

```
/backend        # Spring Boot code
/frontend       # Angular code
```

---

## ⚡ Architecture & Flow

1. The customer or support connects via WebSocket (STOMP/SockJS) to the backend.
2. Messages sent by either party are broadcast to all subscribers (customer and support).
3. No persistence, no separation of topics/rooms: all messages are sent on the same `/chat` channel.
4. The `sender` field allows each message’s role to be identified on display.

*Optional flow diagram*:

```
customer <--- (WS) ---> backend <--- (WS) ---> support
```

---

## ✨ Key Points / Limitations

* **Proof of concept**: no security, no roles management, no database.
* **Simple and readable code**: a single chat component, a single WebSocket route, no unnecessary complexity.
* **Ready to be extended or secured for a production project.**