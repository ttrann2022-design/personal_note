Personal Note App
A cross-platform note-taking application built with Flutter that provides private, user-isolated cloud note management. Users can register an account, sign in securely, create, edit, view, and delete personal notes, with all data synced to the cloud and preserved across sessions.

Features
User Authentication: Email and password registration, login, and secure session handoff using the Firebase Identity Toolkit REST API.

Per-User Cloud Isolation: Notes are organized in Firestore under each user's unique ID (users/{userId}/notes), preventing data crossover between accounts.

Full CRUD Support:

Create: Add new notes with a custom title and content.

Read: Fetch and display real-time persistent notes in a responsive multi-column grid.

Update: Edit existing note titles and contents with live updates.

Delete: Remove notes instantly from both the cloud database and the UI.

Session Persistence & Safety: Logout securely clears active dashboard navigation state and returns the user to the sign-in screen, keeping saved notes intact on Firestore.

Technologies Used
Framework: Flutter (Material 3)

Language: Dart

Backend & Authentication: Firebase Identity Toolkit (REST API)

Database: Google Cloud Firestore (REST API v1)

Networking: http package for Dart (JSON serialization and Bearer token authentication)

Prerequisites
Before running the application, make sure you have installed:

Flutter SDK (version 3.0 or higher recommended)

Dart SDK (bundled with Flutter)

A target emulator, simulator, or browser (Chrome, Android Studio Emulator, or Xcode Simulator)
