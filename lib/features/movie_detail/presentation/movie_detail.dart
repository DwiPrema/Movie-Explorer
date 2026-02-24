import 'package:flutter/material.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/movie_detail/widgets/detail_card.dart';
import 'package:movie_explorer/features/movie_detail/widgets/detail_header.dart';
import 'package:movie_explorer/features/movie_detail/widgets/recomended_movie.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  const MovieDetail({super.key, required this.movieId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            DetailHeader(),
            SizedBox(height: 38,),
            DetailCard(),
            SizedBox(height: 50,),
            RecomendedMovie(),
            SizedBox(),
          ],
        ),
      ),),
    );
  }
}
