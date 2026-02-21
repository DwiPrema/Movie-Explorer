import 'package:flutter/material.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/movie_detail/widgets/detail_header.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  const MovieDetail({super.key, required this.movieId});

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.read<MovieDetailBloc>().add(LoadDetail(movieId: widget.movieId));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailHeader(),
          ],
        ),
      ),
    );
  }
}
