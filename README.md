<div align="center">

# Personal Note App

**A cross-platform note-taking application powered by Flutter and Firebase REST APIs.**

[![Live Demo](https://img.shields.io/badge/Live_Demo-Netlify-00C7B7?style=for-the-badge&logo=netlify&logoColor=white)](https://cute-axolotl-6a0bf6.netlify.app/)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-%23FFCA28.svg?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)

<p align="center">
   <strong>Live Application URL:</strong> <a href="https://cute-axolotl-6a0bf6.netlify.app/">https://cute-axolotl-6a0bf6.netlify.app/</a>
</p>

</div>
---

## Key Features

* **Authentication via REST:** Email & password sign-up, login, and secure session handoff powered directly through the Firebase Identity Toolkit REST API.
* **User Data Isolation:** Notes are organized in Firestore hierarchically under `users/{userId}/notes`, guaranteeing strict data privacy and isolation between users.
* **Full CRUD Capabilities:**
  * **Create:** Add new notes with formatted titles, timestamps, and contents.
  * **Read:** Synchronize and render notes in a responsive adaptive grid.
  * **Update:** In-place modal editing for modifying existing note titles and bodies.
  * **Delete:** Instantly purge documents from Firestore and the local view.
* **Session Persistence & Safety:** Logout safely resets application state and clears navigation history, ensuring private notes are never exposed on shared devices.

---

## Tech Stack & Architecture

| Component | Technology | Description |
| :--- | :--- | :--- |
| **Frontend Framework** | Flutter (Material 3) | Cross-platform UI toolkit targeting Web, Desktop, & Mobile |
| **Language** | Dart | Strong typing, async/await client logic |
| **Authentication** | Firebase Identity Toolkit REST API | Token generation, account creation, and credential validation |
| **Database** | Google Cloud Firestore REST API v1 | Document-based remote NoSQL datastore |
| **Networking** | `http` Package | Direct HTTP methods (`GET`, `POST`, `PATCH`, `DELETE`) with Bearer tokens |

---

## Prerequisites

Before running the application, ensure your environment has:

* **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (`^3.0.0` or higher)
* **[Dart SDK](https://dart.dev/get-dart)** (bundled with Flutter)
* Chrome (for Web) or an active Android/iOS simulator
