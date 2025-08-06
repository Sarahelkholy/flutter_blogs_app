# 📰 Flutter Blogs App (in progress)

This app is being developed following **Clean Architecture principles** using **Flutter** and **Bloc**, with a focus on scalability and testability.  
this project applies layered architecture, modular design, and SOLID principles.

---

## 🚀 Features

- 🔐 Modular authentication and blog features
- ✅ Clean separation of concerns (Data, Domain, Presentation)
- 💾 Local & remote data source support
- 📦 Scalable feature-first architecture
- ⚙️ Bloc state management

---

## 🧰 Tech Stack

- Flutter
- Bloc
- Clean Architecture
- Equatable
- GetIt (dependency injection)
- Dio / HTTP (for remote APIs)
- Dartz (Optional)

---

## 📂 Folder Structure

```
lib/
├── core/
│   ├── common/
│   ├── error/
│   ├── secrets/
│   ├── theme/
│   ├── usecases/
│   └── utils/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   |   │   ├── datasources/
│   |   │   ├── models/
│   |   │   └── repository/
│   │   ├── domain/
│   |   │   ├── repository/
│   |   │   └── usecase/
│   |   └── presentation/
│   |       ├── bloc/
│   |       ├── pages/
│   |       └── widgets/
│   │
│   └── blogs/
│       ├── data/
│       │   ├── datasources/
│       │   └── models/
│       ├── domain/
│       │   └── entities/
│       └── presentation/
│           ├── pages/
│           └── widgets/
│
├── init_dependencies.dart
└── main.dart
```

---

## 📈 Progress (as of ~5h)

- ✅ Feature-based modular structure applied (auth, blogs, etc.)
- ✅ Presentation layer with blocs, widgets, and screens per feature
- ✅ Domain layer structured with entities and use cases per feature
- 🔄 Data layer ongoing: models, datasources per feature
- ⚙️ Dependency injection bootstrapped (`init_dependencies.dart`)

---

## 🔧 Getting Started

### Prerequisites

- Flutter SDK (3.x or higher)
- Dart
- VS Code or Android Studio

### Run the project

```bash
git clone https://github.com/Sarahelkholy/flutter_blogs_app.git
cd flutter_blogs_app
flutter pub get
flutter run
```

---

## 🧑‍💻 Author

**Sarah Elkholy** – [GitHub](https://github.com/Sarahelkholy)

---

## 📌 Notes

This project is a work in progress. New features, refactors, and modules will be added as the course progresses.
