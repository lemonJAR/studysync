# StudySync - Student Task Manager

A mobile app that helps students organize assignments, projects, and deadlines.

## 📱 Features

### Core Features
- **User Authentication**
  - Sign Up & Login
  - Logout
  - Forgot Password

- **Task Management**
  - Add, Edit, Delete tasks
  - Mark tasks as completed
  - Task fields: Title, Description, Due Date, Subject, Status

- **Dashboard**
  - Total Tasks count
  - Completed Tasks count
  - Pending Tasks count
  - Upcoming Deadlines view

- **Task Categories**
  - Assignment
  - Quiz
  - Project
  - Exam
  - Filter by category

- **Notifications**
  - Reminder before due date
  - New task notification

- **User Profile**
  - View/Edit Name, Email
  - Profile Picture
  - Edit Profile

### Bonus Features
- 📝 Study Notes (Save, Edit, Delete)
- 🌙 Dark Mode
- 🔍 Task Search

## 🛠️ Tech Stack

- **Framework:** Flutter
- **State Management:** Riverpod
- **Local Storage:** Hive / SQLite
- **Backend:** Firebase (Auth, Firestore, Cloud Messaging, Storage)
- **Language:** Dart

## 📋 Project Structure

```
studysync/
├── lib/
│   ├── main.dart
│   ├── models/                 # Data models
│   ├── providers/              # Riverpod providers
│   ├── screens/                # UI Screens
│   ├── widgets/                # Reusable widgets
│   ├── services/               # Business logic
│   ├── config/                 # App configuration
│   └── utils/                  # Utilities
├── test/                       # Unit & Widget tests
├── pubspec.yaml               # Dependencies
├── .gitignore
└── README.md
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Git
- IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/USERNAME/studysync.git
   cd studysync
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📅 Development Timeline

- **Phase 1:** Project Setup (GitHub, Flutter)
- **Phase 2:** UI Foundation (Screens Design)
- **Phase 3:** Core Functionality (Task Management)
- **Phase 4:** Advanced Features (Search, Notes, Dark Mode)
- **Phase 5:** Firebase Integration

See `DEVELOPMENT.md` or the project roadmap for detailed timeline.

## 🤝 Contributing

This is a personal learning project. For any improvements, create an issue or pull request.

## 📝 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👤 Author

[Your Name]

## 📞 Contact

For questions or feedback, reach out at [your-email@example.com]

---

**Last Updated:** June 19, 2026
**Current Phase:** Project Setup
