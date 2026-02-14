import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/home_screen/data/model.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor
      ),
      width: MediaQuery.of(context).size.width / 2,
      height: 100,
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: movie.posterUrl()),
          title(movie.title),
          subtitle(movie.year),
        ],
      ),
      
    );
  }
}
