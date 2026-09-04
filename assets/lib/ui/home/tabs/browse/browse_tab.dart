import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/api/model/movies_response.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class BrowseTab extends StatefulWidget {
  final String selectedCategory;

  const BrowseTab({super.key, required this.selectedCategory});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  List<String> categoriesList = [];

  late Future<MoviesResponse> movies;

  final List<Movie> moviesList = [];

  final ScrollController scrollController = ScrollController();

  int currentPage = 1;
  int totalPages = 0;

  bool isLoadingMore = false;
  bool isLoading = true;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);

    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      final genres = await ApiManager.getGenres();

      if (!mounted) return;

      final index = genres.indexOf(widget.selectedCategory);

      setState(() {
        categoriesList = genres;
        selectedCategoryIndex = index == -1 ? 0 : index;
      });

      movies = ApiManager.getMovies(
        limit: 20,
        page: 1,
        genre: categoriesList[selectedCategoryIndex],
        sortBy: 'date_added',
      );

      setState(() {});
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      DialogUtils.showToast(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (categoriesList.isEmpty && !isLoading) {
      return Center(
        child: MainErrorWidget(
          message: 'not_found',
          onPressed: () {
            setState(() {
              isLoading = true;
              loadCategories();
            });
          },
        ),
      );
    }

    if (categoriesList.isEmpty && isLoading) {
      return MainLoadingWidget();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.04,
            top: context.height * 0.02,
          ),
          child: DefaultTabController(
            length: categoriesList.length,
            initialIndex: selectedCategoryIndex,
            child: Column(
              spacing: context.height * 0.02,
              children: [
                TabBar(
                  overlayColor: WidgetStateProperty.all(AppColors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.only(right: context.width * 0.035),
                  dividerColor: AppColors.transparent,
                  indicatorColor: AppColors.transparent,
                  isScrollable: true,
                  onTap: changeCategory,
                  tabs: categoriesList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final category = entry.value;

                    final isSelected = selectedCategoryIndex == index;

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                        vertical: context.height * 0.012,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.yellowColor
                            : AppColors.transparent,
                        border: Border.all(color: AppColors.yellowColor),
                        borderRadius: BorderRadius.circular(
                          context.width * 0.035,
                        ),
                      ),
                      child: Text(
                        category,
                        style: isSelected
                            ? AppStyles.reg16BlackRoboto
                            : AppStyles.reg16YellowRoboto,
                      ),
                    );
                  }).toList(),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: context.width * 0.04),
                    child: FutureBuilder<MoviesResponse>(
                      future: movies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const MainLoadingWidget();
                        }

                        if (snapshot.hasError) {
                          return MainErrorWidget(
                            message: snapshot.error.toString().replaceFirst(
                              'Exception: ',
                              '',
                            ),
                            onPressed: () {
                              setState(() {
                                movies = ApiManager.getMovies(
                                  limit: 20,
                                  page: currentPage,
                                  genre: categoriesList[selectedCategoryIndex],
                                  sortBy: 'date_added',
                                );
                              });
                            },
                          );
                        }

                        if (snapshot.hasData && moviesList.isEmpty) {
                          final response = snapshot.data!;

                          moviesList.addAll(response.movies);
                          totalPages = response.totalPages;
                        }

                        if (moviesList.isEmpty) {
                          return MainErrorWidget(
                            message: 'not_found',
                            onPressed: () {
                              setState(() {
                                movies = ApiManager.getMovies(
                                  limit: 20,
                                  page: currentPage,
                                  genre: categoriesList[selectedCategoryIndex],
                                  sortBy: 'date_added',
                                );
                              });
                            },
                          );
                        }

                        return CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            SliverGrid(
                              delegate: SliverChildBuilderDelegate((
                                context,
                                index,
                              ) {
                                return MovieCard(movie: moviesList[index]);
                              }, childCount: moviesList.length),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: context.width * 0.04,
                                    mainAxisSpacing: context.height * 0.02,
                                    childAspectRatio: 0.65,
                                  ),
                            ),

                            if (isLoadingMore)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.height * 0.025,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),

                            if (!isLoadingMore &&
                                totalPages > 0 &&
                                currentPage >= totalPages)
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.height * 0.025,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'no_more_movies'.tr(),
                                      style: AppStyles.reg16WhiteRoboto,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
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

  void changeCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;

      currentPage = 1;
      totalPages = 0;

      moviesList.clear();
      isLoadingMore = false;

      movies = ApiManager.getMovies(
        limit: 20,
        page: 1,
        genre: categoriesList[index],
        sortBy: 'date_added',
      );
    });
  }

  void scrollListener() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.maxScrollExtent <= 0) {
      return;
    }

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreMovies();
    }
  }

  Future<void> loadMoreMovies() async {
    if (isLoadingMore) return;

    if (currentPage >= totalPages) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final nextPage = currentPage + 1;

      final response = await ApiManager.getMovies(
        limit: 20,
        page: nextPage,
        genre: categoriesList[selectedCategoryIndex],
        sortBy: 'date_added',
      );

      if (!mounted) return;

      setState(() {
        currentPage = nextPage;
        moviesList.addAll(response.movies);
      });
    } catch (e) {
      if (!mounted) return;

      DialogUtils.showToast(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoadingMore = false;
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}
