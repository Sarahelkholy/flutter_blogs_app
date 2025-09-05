# 📰 Flutter Blogs App

A **fully functional blog posting app** built with **Flutter** using **Bloc** for state management and **Clean Architecture principles** for a scalable and maintainable codebase.

This project demonstrates:
- Feature-first modular design
- Proper separation of concerns across Data, Domain, and Presentation layers
- Offline support using local Hive storage
- Integration with Supabase for authentication and blog management

---

## 🚀 Features

- 🔐 User Authentication (Sign up, Login, Logout)
- ✍️ Create & View Blogs
- 💾 Local caching with Hive
- 🌐 Remote integration with Supabase
- ⚙️ Bloc state management with clean event/state separation
- 🧼 Clean Architecture: Data → Domain → Presentation
- 🧪 Testable and modular codebase

---

## 🧰 Tech Stack

- **Flutter**
- **Bloc**
- **Hive (local DB)**
- **Supabase (auth + backend)**
- **Clean Architecture**
- **GetIt** (Dependency Injection)
- **Fpdart** (Either monads)
- **Equatable** (for state comparison)

---

## 📂 Folder Structure

```
lib/
├── core/
│   ├── common/             # Shared cubits, widgets
│   ├── constants/          # App constants
│   ├── error/              # Failures & exceptions
│   ├── network/            # Connectivity checker
│   ├── secrets/            # Supabase keys
│   ├── theme/              # App theme
│   ├── usecases/           # Base UseCase class
│   └── utils/              # Snackbars, helpers
│
├── features/
│   ├── auth/               # Authentication feature
│   │   ├── data/           
│   │   ├── domain/         
│   │   └── presentation/   
│
│   └── blogs/              # Blog feature
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── init_dependencies.dart        # Service locator (GetIt)
├── init_dependencies.main.dart
└── main.dart
```

## 🧪 How to Run

### ✅ Prerequisites

- Flutter SDK (3.10 or higher)
- Dart
- Emulator or physical device

### ▶️ Run the App

```bash
git clone https://github.com/Sarahelkholy/flutter_blogs_app.git
cd flutter_blogs_app
flutter pub get
flutter run
```

---

## 📦 Supabase Setup

You must create a [Supabase](https://supabase.com/) project and configure the following:

### `profiles` Table:
| Column | Type | Notes        |
|--------|------|--------------|
| id     | uuid | Primary Key  |
| name   | text |              |
| email  | text |              |

### `blogs` Table:
| Column   | Type | Notes        |
|----------|------|--------------|
| id       | uuid | Primary Key  |
| title    | text |              |
| content  | text |              |
| user_id  | uuid | Foreign Key (references profiles.id) |

### Add Supabase keys in:

```dart
// lib/core/secrets/app_secrets.dart
class AppSecrets {
  static const supabaseUrl = 'your-project-url';
  static const supabaseAnonKey = 'your-anon-key';
}
```

---

## 👤 Author

**Sarah Elkholy**  
📂 [GitHub Profile](https://github.com/Sarahelkholy)

---

## 📌 Notes

This project is complete and can be extended with:
- Comment and like functionality
- Rich text editor for blogs
- Firebase or OAuth login providers
- Full offline sync support

---

## Screen record


https://github.com/user-attachments/assets/3dae4cb7-44fa-4c9d-85ca-dd5626bb45a2


---



## ⭐️ Show Your Support

If you like this project, give it a ⭐️ on [GitHub](https://github.com/Sarahelkholy/flutter_blogs_app)!
