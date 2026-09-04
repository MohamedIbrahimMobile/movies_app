import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movies_response.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/available_movies.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_category.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

typedef OnBrowseTap = Function(String selectedCategory);

class HomeTab extends StatefulWidget {
  final OnBrowseTap onBrowseTap;

  const HomeTab({super.key, required this.onBrowseTap});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late Future<List<MoviesResponse>> homeMovies;

  String selectedCategory = '';

  @override
  void initState() {
    super.initState();

    homeMovies = getHomeMovies();
  }

  Future<List<MoviesResponse>> getHomeMovies() async {
    final genres = await ApiManager.getGenres();

    selectedCategory = genres[Random().nextInt(genres.length)];

    return Future.wait([
      ApiManager.getMovies(sortBy: 'date_added'),
      ApiManager.getMovies(genre: selectedCategory, sortBy: 'date_added'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MoviesResponse>>(
        future: homeMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MainLoadingWidget();
          }

          if (snapshot.hasError) {
            return MainErrorWidget(
              width: double.infinity,
              message: snapshot.error.toString().replaceFirst(
                'Exception: ',
                '',
              ),
              onPressed: () {
                setState(() {
                  homeMovies = getHomeMovies();
                });
              },
            );
          }

          final availableMovies = snapshot.data?[0].movies ?? [];
          final categoryMovies = snapshot.data?[1].movies ?? [];

          if (availableMovies.isEmpty || categoryMovies.isEmpty) {
            return MainErrorWidget(
              message: 'not_found',
              onPressed: () {
                setState(() {
                  homeMovies = getHomeMovies();
                });
              },
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: kBottomNavigationBarHeight + context.height * 0.042,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: context.height * 0.02,
                children: [
                  AvailableMovies(movies: availableMovies),

                  MovieCategory(
                    selectedCategory: selectedCategory,
                    movies: categoryMovies,
                    onTap: () {
                      widget.onBrowseTap(selectedCategory);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
