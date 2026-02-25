import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_explorer/features/movie_detail/widgets/detail_card.dart';
import 'package:movie_explorer/features/movie_detail/widgets/detail_header.dart';
import 'package:movie_explorer/features/movie_detail/widgets/recomended_movie.dart';
import 'package:movie_explorer/widgets/error_widget/error_page.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailSuccess) {
                return Column(
                  children: [
                    DetailHeader(state: state.detail),
                    const SizedBox(height: 38),
                    DetailCard(state: state.detail),
                    const SizedBox(height: 50),
                    RecommendedMovieSection(movies: state.movies),
                    const SizedBox(),
                  ],
                );
              } else if (state is MovieDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.white,
                  ),
                );
              } else if (state is MovieDetailError) {
                return ErrorPage(errMsg: state.errMsg);
              } else {
                return const ErrorPage(errMsg: "Something Went Wrong !");
              }
            },
          ),
        ),
      ),
    );
  }
}
