import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class BrowseTab extends StatefulWidget {
  int selectedCategory;

  BrowseTab({super.key, required this.selectedCategory});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  late Future<List<Movie>> movies;

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
    // TODO: implement initState
    super.initState();
    movies = ApiManager.getMovies(
      limit: 30,
      genre: categoriesList[widget.selectedCategory],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.04,
            top: context.height * 0.02,
          ),
          child: DefaultTabController(
            length: categoriesList.length,
            initialIndex: widget.selectedCategory,
            child: Column(
              spacing: context.height * 0.02,
              children: [
                TabBar(
                  onTap: (index) {
                    setState(() {
                      widget.selectedCategory = index;
                      movies = ApiManager.getMovies(
                        limit: 30,
                        genre: categoriesList[index],
                      );
                    });
                  },
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: context.width * 0.035),
                  dividerColor: AppColors.transparent,
                  indicatorColor: AppColors.blackColor,
                  isScrollable: true,
                  tabs: categoriesList.map((category) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                        vertical: context.height * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color:
                            widget.selectedCategory ==
                                categoriesList.indexOf(category)
                            ? AppColors.yellowColor
                            : AppColors.transparent,
                        border: Border.all(color: AppColors.yellowColor),
                        borderRadius: BorderRadius.circular(
                          context.width * 0.035,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category.tr(),
                        style:
                            widget.selectedCategory ==
                                categoriesList.indexOf(category)
                            ? AppStyles.reg16BlackRoboto
                            : AppStyles.reg16YellowRoboto,
                      ),
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: context.width * 0.04),
                    child: FutureBuilder<List<Movie>>(
                      future: movies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return MainLoadingWidget();
                        } else if (snapshot.hasError) {
                          return MainErrorWidget(
                            message: snapshot.error.toString(),
                            onPressed: () {
                              ApiManager.getMovies(
                                limit: 30,
                                genre: categoriesList[widget.selectedCategory],
                              );
                              setState(() {});
                            },
                          );
                        } else {
                          List<Movie> moviesList = snapshot.data!;
                          return GridView.builder(
                            itemCount: moviesList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: context.width * 0.04,
                                  mainAxisSpacing: context.height * 0.02,
                                  childAspectRatio: 0.65,
                                ),
                            itemBuilder: (context, index) {
                              return MovieCard(movie: moviesList[index]);
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
