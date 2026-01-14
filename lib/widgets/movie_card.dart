import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
      ),
      width: MediaQuery.of(context).size.width / 2,
      height: 100,
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: movie.poster),
        ],
      ),
      
    );
  }
}
