import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/features/home.dart';

void main() {
  runApp(const MovieExplorer());
}

class MovieExplorer extends StatelessWidget {
  const MovieExplorer({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
