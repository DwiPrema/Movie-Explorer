import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/core/routes/app_routes.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_bloc.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_event.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_state.dart';
import 'package:movie_explorer/features/search_screen/presentation/loading_search_widget.dart';
import 'package:movie_explorer/features/search_screen/widgets/movie_tile_card.dart';
import 'package:movie_explorer/widgets/error_widget/error_widget.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SearchBloc>().add(
          DisplaySearchedMovie(query: _searchController.text),
        );
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff303030),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        context.read<SearchBloc>().add(
                          DisplaySearchedMovie(query: value),
                        );
                      },
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                      ),
                      controller: _searchController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: AppColors.grey),
                        hintText: "Search Movie...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              if (state is SearchInitial)
               Center(
                    child: subtitle(
                      "Type to search...",
                      color: AppColors.white,
                    ),
                  ),

              if (state is SearchLoading)
                ...List.generate(
                  5,
                  (_) => const RepaintBoundary(child: LoadingSearchWidget()),
                ),

              if (state is SearchEmpty)
                Center(child: subtitle(state.message, color: AppColors.white)),

              if (state is SearchLoaded)
                ...state.searchResults.map((movie) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.toDetail,
                        arguments: {
                          'movieId': movie.movieId,
                          'genreId': movie.genreIds.isNotEmpty
                              ? movie.genreIds
                              : 28,
                        },
                      );
                    },
                    child: RepaintBoundary(
                      child: MovieTileCard(
                        titleMovie: movie.title,
                        posterUrl: movie.posterUrl,
                        genres: movie.genreNames,
                        popularity: movie.popularity,
                      ),
                    ),
                  );
                }),

              if (state is SearchError) ErrorPage(errMsg: state.errMsg),

              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }
}
