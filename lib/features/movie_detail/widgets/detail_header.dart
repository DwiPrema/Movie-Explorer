import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_omdbid_api/widgets/widget_text.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieDetailSuccess) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      state.detail.backdropUrl(),
                      width: double.infinity,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is MovieDetailError) {
          return Center(child: title("Error"));
        } else {
          return Center(child: title("Something went wrong :("));
        }
      },
    );
  }
}
