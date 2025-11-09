# afrifound_assesment_app

 # MVVM Hive CRUD Flutter App
 # Overview

This Flutter application demonstrates a simple CRUD (Create, Read, Update, Delete) system using the MVVM architecture with Hive as the local database and Riverpod for state management.
It allows users to add, edit, and delete items (e.g., notes or tasks) and persists them locally even after app restarts.
Additionally, it includes a persistent light/dark theme toggle that stores user preference in Hive.

 # Architecture

The app follows a clean MVVM pattern:

lib/
├── models/
│   └── item_model.dart           # Data model (Hive type)
├── services/
│   └── local_storage_service.dart # Hive service layer
├── viewmodels/
│   ├── home_viewmodel.dart       # Handles CRUD logic
│   └── theme_viewmodel.dart      # Handles theme toggle logic
├── views/
│   ├── home_screen.dart           # Displays list of items
│   └── add_edit_screen.dart       # Add/Edit item UI
└── main.dart                      # Entry point with theme provider

 # Features

✅ Add, edit, and delete items
✅ Swipe-to-delete functionality
✅ Persistent data storage with Hive
✅ Light/Dark mode toggle (saved via Hive)
✅ Riverpod for reactive state management
✅ Clean separation of logic and UI (MVVM)

# Dependencies

Add the following to your pubspec.yaml:

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0


Run:

flutter pub get

# Hive Setup

Initialize Hive in your main.dart:

await Hive.initFlutter();
await LocalStorageService.init();
await Hive.openBox('themeBox');


Register your adapters inside LocalStorageService.init():

Hive.registerAdapter(ItemModelAdapter());
await Hive.openBox<ItemModel>('itemsBox');

# How to Run

Clone this repository:

git clone git@github.com:Wakilspace/afrifound_assessment_app.git


Open the project in VS Code or Android Studio.

Run the app:

flutter run

# Theme Toggle

The theme state is persisted using Hive:

Tap the 🌙/☀️ icon in the top-right corner to switch modes.

The theme preference is saved automatically.

 How MVVM is Applied

Model: Defines data structure (ItemModel) and Hive type.

ViewModel: (HomeViewModel) contains business logic for CRUD.

View: (HomeScreen, AddEditScreen) reacts to ViewModel state changes through Riverpod.


	
	
Author

Developed by: [Your Name]
GitHub: Wakilspace