# Blog App

A modern, full-featured blogging application built with Flutter. This app demonstrates best practices in Flutter development, including clean architecture, state management with BLoC, dependency injection, and integration with Supabase and Hive for backend and local storage.

---

## ✨ Features

- **User Authentication:** Secure sign-up and login using email and password, managed via Supabase.
- **Blog Creation:** Authenticated users can create new blogs, add images, and select from predefined topics.
- **Blog Feed:** All users can view a list of blogs, each displaying its title, topics, and estimated reading time.
- **Blog Details:** Tap on any blog to view its full content, author, image, and metadata.
- **Offline Support:** Blogs are cached locally using Hive, so users can read blogs even without an internet connection.
- **State Management:** All business logic and UI state are managed using the BLoC pattern for scalability and testability.
- **Dependency Injection:** All dependencies are managed and injected using GetIt, making the codebase modular and easy to maintain.
- **Error Handling:** User-friendly error messages and loading indicators are shown throughout the app.

---

## 🏗️ Project Structure

The project follows a **feature-first, clean architecture** approach:

```
lib/
  core/           # Common utilities, themes, constants, error handling
  features/
    auth/         # Authentication (data, domain, presentation)
    blog/         # Blog feature (data, domain, presentation)
  main.dart       # App entry point
  init_dependencies.dart  # Dependency injection setup
```

### Layered Structure

- **Data Layer:** Handles all data operations, including API calls (Supabase) and local storage (Hive). Contains models, repositories, and data sources.
- **Domain Layer:** Contains business logic, entities (like `User` and `Blog`), and use cases (e.g., `UserLogin`, `UploadBlog`).
- **Presentation Layer:** UI components, pages, widgets, and BLoC classes for state management.

---

## 🧩 Architecture Overview

### 1. **State Management (BLoC)**
- Each feature (Auth, Blog) has its own BLoC class.
- Events are dispatched to BLoC, which processes them and emits new states.
- UI listens to state changes and rebuilds accordingly.

### 2. **Dependency Injection (GetIt)**
- All services, repositories, and BLoCs are registered in `init_dependencies.dart`.
- This allows for easy swapping of implementations and better testability.

### 3. **Data Flow**
- **Authentication:**  
  - User actions (sign up, login) trigger Auth BLoC events.
  - Auth BLoC uses use cases, which interact with the Auth Repository.
  - The repository communicates with Supabase for authentication.
- **Blog Management:**  
  - Blog BLoC handles fetching, uploading, and displaying blogs.
  - Blogs are fetched from Supabase and cached locally with Hive.
  - When creating a blog, images are picked from the device and uploaded.

### 4. **Entities and Models**
- **User:**  
  - Contains `id`, `email`, and `name`.
- **Blog:**  
  - Contains `id`, `posterId`, `title`, `content`, `imageUrl`, `topics`, `updatedAt`, and `posterName`.

### 5. **UI/UX**
- The app uses a custom dark theme and Material Design.
- Navigation is handled via Flutter's Navigator.
- Forms are validated before submission.
- Loading indicators and error snackbars provide feedback.

---

## 🛠️ Technologies & Dependencies

- **Flutter**: UI toolkit for building natively compiled applications.
- **flutter_bloc**: State management.
- **get_it**: Dependency injection.
- **supabase_flutter**: Backend as a service (authentication, database, storage).
- **hive**: Lightweight, fast local database.
- **image_picker**: For selecting images from the device.
- **dotted_border, intl, uuid, fpdart, internet_connection_checker_plus**: Various utilities for UI, formatting, unique IDs, functional programming, and network checking.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed ([Install Guide](https://docs.flutter.dev/get-started/install))
- A Supabase project (for backend)

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd blog_app
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Configure Supabase:**
   - Add your Supabase URL and anon key.

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📚 Usage

- **Sign Up / Login:**  
  Create a new account or log in with existing credentials. The app checks if the user is logged in and navigates accordingly.
- **Create Blog:**  
  Tap the add button, fill in the title, content, select topics, and upload an image. Blogs are uploaded to Supabase and cached locally.
- **View Blogs:**  
  Browse the feed, tap a blog to read in detail. Blogs display title, topics, author, image, and content.
- **Offline Support:**  
  Blogs are cached locally for offline access. If the network is unavailable, the app shows cached blogs and notifies the user.

---


---

---

## 🙏 Acknowledgements

- [Flutter](https://flutter.dev/)
- [Supabase](https://supabase.com/)
- [Hive](https://docs.hivedb.dev/)
- [BLoC](https://bloclibrary.dev/)

---

