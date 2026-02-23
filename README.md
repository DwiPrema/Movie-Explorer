# Movie Explorer 🎬

Movie Explorer is a Flutter application that allows users to explore movies using the TMDB API.

This project is built as a learning project to practice Flutter, REST API integration, and BLoC state management.

## Features
- Display popular movies
- Movie detail page
- Loading handling
- Clean architecture (core & features separation)
- BLoC state management

## Tech Stack
- **Flutter**
- **Dart**
- **BLoC (flutter_bloc)**
- **Dio** (REST API)
- **Cached Network Image**
- **Carousel Slider**
- **TMDB API**
- **Environment Variables** (`flutter_dotenv`)

## 📁 Project Structure (Simplified)

```text
lib/
├── core/
│   ├── constant/
│   ├── network/
│   ├── routes/
│   └── utils/
├── features/
│   ├── home_screen/
│   │   ├── bloc/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── services/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── widgets/
│   └── movie_detail/
│       ├── bloc/
│       ├── data/
│       │   ├── models/
│       │   └── services/
│       ├── presentation/
│       └── widgets/
├── widgets/
└── main.dart


## Screenshots
🚧 Screenshots will be added soon

## Project Status
🚧 In Progress  
Planned features:
- Error handling
- Search movie
- Favorite movie