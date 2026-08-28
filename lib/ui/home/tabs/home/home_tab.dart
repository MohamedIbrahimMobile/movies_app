import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/available_movies.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_category.dart';
import 'package:movies_app/utils/size_utils.dart';

typedef OnBrowseTap = Function(int currentCategory);

class HomeTab extends StatefulWidget {
  final OnBrowseTap onBrowseTap;

  const HomeTab({super.key, required this.onBrowseTap});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = '';

  final List<String> categoriesList = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Fantasy',
    'Music',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = getRandomGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + context.height * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: context.height * 0.012,
            children: [
              AvailableMovies(),
              MovieCategory(
                selectedCategory: selectedCategory,
                onTap: () {
                  widget.onBrowseTap(categoriesList.indexOf(selectedCategory));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getRandomGenre() {
    final availableGenres = categoriesList
        .where((genre) => genre != selectedCategory)
        .toList();

    return availableGenres[Random().nextInt(availableGenres.length)];
  }
}
