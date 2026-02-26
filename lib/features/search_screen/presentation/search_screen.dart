import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/constant/colors.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_bloc.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_event.dart';
import 'package:movie_explorer/features/search_screen/bloc/search_state.dart';
import 'package:movie_explorer/features/search_screen/widgets/movie_tile_card.dart';
import 'package:movie_explorer/widgets/error_widget/error_widget.dart';
import 'package:movie_explorer/widgets/reusable_widget/widget_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: _isSearching
              ? TextField(
                  onChanged: (value) {
                    context.read<SearchBloc>().add(
                      DisplaySearchedMovie(query: value),
                    );
                  },
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search Movie...",
                    border: InputBorder.none,
                  ),
                )
              : const SizedBox.shrink(),

          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
            ),
          ],
        ),

        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchInitial) {
              Center(
                child: subtitle("Type to search...", color: AppColors.white),
              );
            }

            if (state is SearchLoading) {
              const Center(child: CircularProgressIndicator());
            }

            if (state is SearchLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.searchResults[index];
                  return MovieTileCard(
                    title: movie.title,
                    posterUrl: movie.posterUrl(size: "w324"),
                    genres: movie.genreNames(),
                    popularity: movie.popularity,
                  );
                },
              );
            }

            if (state is SearchError) {
              return ErrorPage(errMsg: state.errMsg);
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
