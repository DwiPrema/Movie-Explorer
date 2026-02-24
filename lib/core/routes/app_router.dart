import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/routes/app_routes.dart';
import 'package:movie_explorer/features/home_screen/presentation/home_screen.dart';
import 'package:movie_explorer/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_explorer/features/movie_detail/presentation/movie_detail.dart';
import 'package:movie_explorer/widgets/widget_text.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.toDetail:
        final args = settings.arguments as Map<String, dynamic>;

        final int movieId = args['movieId'];
        final int genreId = args['genreId'];

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => MovieDetailBloc()
              ..add(LoadDetail(movieId: movieId, genreId: genreId)),
            child: MovieDetail(movieId: movieId),
          ),
        );

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: title("Page Not Found"))),
        );
    }
  }
}
