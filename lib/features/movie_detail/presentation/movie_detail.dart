import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/movie_detail/widgets/detail_card.dart';
import 'package:movie_omdbid_api/features/movie_detail/widgets/detail_header.dart';

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
            DetailCard(),
          ],
        ),
      ),),
    );
  }
}
