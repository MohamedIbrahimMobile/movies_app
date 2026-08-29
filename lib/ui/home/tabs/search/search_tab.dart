import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_text_field.dart';
import '../../../../api/api_manager.dart';
import '../../../../api/model/movie.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = '' ;
  Future<List<Movie>>? searchFuture;

  void onSearchChanged(String value) {
    setState(() {
      query = value;
      if (query.trim().isNotEmpty) {
        searchFuture = ApiManager.searchMovie(query);
      } else {
        searchFuture = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.04,
            vertical: context.height * 0.02,
          ),
          child: Column(
            spacing: context.height*0.02,
            children: [
              Container(
                height: context.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.darkGrayColor,
                  borderRadius: BorderRadius.circular(context.width * 0.03),
                ),
                child: CustomTextField(
                  onChanged: onSearchChanged,
                  prefixIcon: Image.asset(AppAssets.searchIcon),
                  fillColor: AppColors.darkGrayColor,
                  fill: true,
                  hintText: 'search'.tr(),
                  hintStyle: AppStyles.reg14WhiteRoboto,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Expanded(
                child: query.trim().isEmpty ? Center(
                  child: Image.asset(
                    AppAssets.watchListImage,
                    width: context.width * 0.30,
                  ),
                )
                    : FutureBuilder<List<Movie>>(
                  future: searchFuture,
                  builder:(context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          style:  TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return  Center(
                        child: Text(
                          'No movies found'.tr(),
                          style: AppStyles.bold24WhiteRoboto,
                        ),
                      );
                    }else {
                      List<Movie> moviesList = snapshot.data!;
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            final movie = moviesList[index];
                            return ListTile(
                              titleAlignment: ListTileTitleAlignment.top,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.movieDetailsScreenRouteName,
                                    arguments: movie.id
                                );
                              },
                              leading: ClipRRect(
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(
                                  width: context.width*0.1,
                                  height: context.height*0.1,
                                  child: Image.network(
                                    movie.mediumCoverImage ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                movie.title ?? '',
                                style: AppStyles.bold20WhiteRoboto,
                              ),
                              subtitle: Text(
                                '${movie.year ?? ''} • ⭐ ${movie.rating ?? ''}',
                                style: AppStyles.reg16LightGrayRoboto,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: context.height*0.01);
                          },
                          itemCount: moviesList.length
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
