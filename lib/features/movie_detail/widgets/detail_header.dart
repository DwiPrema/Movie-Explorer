import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_omdbid_api/core/constant/colors.dart';
import 'package:movie_omdbid_api/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_omdbid_api/widgets/readmore_text.dart';
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
          return Column(
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        state.detail.backdropUrl(),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.bgColor,
                              AppColors.bgColor.withAlpha(127),
                              Colors.transparent,
                              Colors.transparent,
                              AppColors.bgColor.withAlpha(127),
                              AppColors.bgColor,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Back button & title
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: CircleAvatar(
                                backgroundColor: AppColors.white.withAlpha(50),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          subtitle(
                            "DISPLAY MOVIE DETAILS",
                            align: TextAlign.center,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ],
                      ),
                    ),

                    // Movie title
                    Positioned(
                      left: 16,
                      bottom: 5,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.detail.title,
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "RacingSansOne",
                              fontSize: 38,
                              fontWeight: FontWeight.w900,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      subtitle(
                        "${state.detail.popularity} popularity",
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                      const SizedBox(height: 16),
                      ReadmoreText(text: state.detail.overview),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
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
