import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_explorer/features/movie_detail/widgets/detail_card.dart';
import 'package:movie_explorer/features/movie_detail/widgets/detail_header.dart';
import 'package:movie_explorer/features/movie_detail/widgets/recomended_movie.dart';
import 'package:movie_explorer/widgets/widget_text.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  const MovieDetail({super.key, required this.movieId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            const DetailHeader(),
            const DetailCard(),
            BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailSuccess) {
          return RecommendedMovieSection(movies: state.movies);
        } else if (state is MovieDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieDetailError) {
          return title("Sorry! Error");
        } else {
          return title("Sorry! Something Went Wrong !!!");
        }
      },
    ),
          ],
        ),
      ),),
    );
  }
}
