import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/core/routes/app_routes.dart';
import 'package:movie_omdbid_api/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_omdbid_api/features/movie_detail/presentation/movie_detail.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.toDetail:
        final movieId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => MovieDetailBloc()..add(LoadDetail(movieId: movieId)),
            child: MovieDetail(movieId: movieId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: title("Page Not Found"))),
        );
    }
  }
}
