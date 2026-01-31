import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/features/home.dart';
import 'package:movie_omdbid_api/features/home_screen/movie_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MovieExplorer(),
    ),
  );
}

class MovieExplorer extends StatelessWidget {
  const MovieExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}
