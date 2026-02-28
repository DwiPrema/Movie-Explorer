# Movie Explorer 🎬

Movie Explorer is a Flutter application that allows users to explore movies using the TMDB API.

This project is built as a learning project to practice Flutter, REST API integration, and BLoC state management.

## Features
- Display up-coming, now playing, popular and top rated movies
- Movie detail page
    - Detail Movie
    - Recommended movie (Content-Based Recommendation System)
- Search Movie
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
│   ├── error/
│   ├── models/
│   ├── network/
│   ├── routes/
│   ├── utils/
│   └── view_model/
├── features/
│   ├── genres_features/
│   │   ├── bloc/
│   │   └── data/
│   │       ├── model/
│   │       └── services/
│   ├── home_screen/
│   │   ├── bloc/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── services/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── widgets/
│   ├── movie_detail/
│   │   ├── bloc/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── services/
│   │   ├── presentation/
│   │   └── widgets/
│   └── search_screen/
│       ├── bloc/
│       ├── data/
│       │   └── services/
│       ├── presentation/
│       └── widgets/
├── widgets
    ├── error_widget/
    ├── image/
    └── reusable_widget/
└── main.dart
```
## Screenshots
🚧 Screenshots will be added soon

## Project Status
🚧 In Progress  
Planned features:
- Favorite movie
- Find by genre