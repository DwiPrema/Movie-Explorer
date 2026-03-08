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
  final ScrollController _scrollLoadController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollLoadController.addListener(() {
      if (_scrollLoadController.position.pixels >=
          _scrollLoadController.position.maxScrollExtent - 500) {
        context.read<SearchBloc>().add(LoadMoreMovie());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollLoadController.dispose();
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
      child: Column(
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
                  style: const TextStyle(color: AppColors.white, fontSize: 14),
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

          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return _buildSearchContent(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchContent(SearchState state) {
    if (state is SearchInitial) {
      return Center(
        child: subtitle("Type to search...", color: AppColors.white),
      );
    }

    if (state is SearchLoading) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) => const LoadingSearchWidget(),
      );
    }

    if (state is SearchEmpty) {
      Center(child: subtitle(state.message, color: AppColors.white));
    }

    if (state is SearchLoaded) {
      return ListView.builder(
        controller: _scrollLoadController,
        padding: const EdgeInsets.only(bottom: 60),
        itemCount: state.searchResults.length,
        itemBuilder: (context, index) {
          final movie = state.searchResults[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.toDetail,
                arguments: {
                  'movieId': movie.movieId,
                  'genreId': movie.genreIds.isNotEmpty ? movie.genreIds : 28,
                },
              );
            },
            child: MovieTileCard(
              titleMovie: movie.title,
              posterUrl: movie.posterUrl,
              genres: movie.genreNames,
              popularity: movie.popularity,
            ),
          );
        },
      );
    }

    if (state is SearchError) {
      ErrorPage(errMsg: state.errMsg);
    }

    return const SizedBox.shrink();
  }
}
