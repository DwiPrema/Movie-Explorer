import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_explorer/widgets/widget_text.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailSuccess) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Poster
                Flexible(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      state.detail.posterUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
      
                // Movie info
                Flexible(
                  flex: 1,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoText("Original title", state.detail.originalTitle),
                        _InfoText("Original language", state.detail.originalLanguage),
                        _InfoText("Released date", state.detail.releaseDate),
                        _InfoText("Production country", state.detail.productionCountriesText.toString()),
                        _InfoText("Status", state.detail.status),
                        _InfoText("Tagline", state.detail.tagline),
                        _InfoText("Genres", state.detail.genresText),
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
        ),
      ),
    );
  }
}



class _InfoText extends StatelessWidget {
  final String label;
  final String value;

  const _InfoText(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label : ",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "RedHatDisplay",
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: "RedHatDisplay",
                color: AppColors.grey,
                fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
