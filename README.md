# 🎬 Movie Explorer

Movie Explorer is an simple flutter application that displays movie information using **TMDB (The Movie Database) API**.  
this project built for **learning purpose, practice, and portfolio showcase** focusing on clean architecture and state management

---

## ✨ Features

- Displays list **Upcoming Movies** from TMDB
- Movie poster carousel slider
- State management using **BLoC**
- Separated architecture (data, service, bloc, presentation)
- Loading & error state handling
- REST API consumption using **Dio**

---

## 🧠 Technologies Used

- **Flutter**
- **Dart**
- **flutter_bloc**
- **Dio**
- **Carousel Slider**
- **TMDB API**

---

## 📁 Project Structure (Simplified)

```text
lib/
├── core/
│   ├── constant/
│   ├── network/
│   ├── routes/
│   └── utils
├── features/
│   └── home_screen/
│       ├── bloc/
│       ├── data/
│       │   ├── model.dart
│       │   └── service.dart
│       └── presentation/
├── widgets/
└── main.dart
