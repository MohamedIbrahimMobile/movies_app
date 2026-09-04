import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_text_field.dart';
import 'package:movies_app/widgets/image_error_placeholder.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String query = '';
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
          padding: EdgeInsets.only(
            left: context.width * 0.04,
            right: context.width * 0.04,
            top: context.height * 0.02,
          ),
          child: Column(
            spacing: context.height * 0.02,
            children: [
              CustomTextField(
                radius: context.width * 0.04,
                onChanged: onSearchChanged,
                prefixIcon: Image.asset(AppAssets.searchIcon),
                fillColor: AppColors.darkGrayColor,
                fill: true,
                hintText: 'search'.tr(),
                hintStyle: AppStyles.reg14WhiteRoboto,
                keyboardType: TextInputType.text,
              ),

              Expanded(
                child: query.trim().isEmpty
                    ? Center(
                        child: Image.asset(
                          AppAssets.watchListImage,
                          width: context.width * 0.30,
                        ),
                      )
                    : FutureBuilder<List<Movie>>(
                        future: searchFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return MainLoadingWidget();
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
                                  searchFuture = ApiManager.searchMovie(query);
                                });
                              },
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                'not_found'.tr(),
                                style: AppStyles.bold20WhiteRoboto,
                              ),
                            );
                          }

                          final moviesList = snapshot.data!;

                          return ListView.separated(
                            itemBuilder: (context, index) {
                              final movie = moviesList[index];

                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.movieDetailsScreenRouteName,
                                        arguments: movie.id,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.width * 0.024,
                                        vertical: context.height * 0.012,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.darkGrayColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Directionality(
                                        textDirection: ui.TextDirection.ltr,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: context.width * 0.035,
                                          children: [
                                            Container(
                                              width: context.width * 0.285,
                                              height: context.height * 0.18,
                                              alignment: Alignment.topLeft,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    movie.mediumCoverImage ??
                                                        '',
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) => Stack(
                                                          children: [
                                                            ImageErrorPlaceholder(),
                                                            Container(
                                                              color: AppColors
                                                                  .blackColor
                                                                  .withValues(
                                                                    alpha: 0.5,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              context.width *
                                                              0.013,
                                                          vertical:
                                                              context.height *
                                                              0.0057,
                                                        ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              context.width *
                                                              0.016,
                                                          vertical:
                                                              context.height *
                                                              0.004,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .blackColor
                                                          .withValues(
                                                            alpha: 0.7,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            11,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      spacing:
                                                          context.width * 0.007,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          movie.rating
                                                              .toString(),
                                                          style: AppStyles
                                                              .reg16WhiteRoboto,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color: AppColors
                                                              .yellowColor,
                                                          size:
                                                              context.width *
                                                              0.04,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: context.height * 0.0057,
                                                  right: context.width * 0.013,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  spacing:
                                                      context.height * 0.018,
                                                  children: [
                                                    Text(
                                                      movie.title ?? '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppStyles
                                                          .bold20WhiteRoboto
                                                          .copyWith(
                                                            fontSize: 18,
                                                          ),
                                                    ),

                                                    Text(
                                                      '${movie.year ?? ''}',
                                                      style: AppStyles
                                                          .reg16LightGrayRoboto,
                                                    ),

                                                    if (movie.genres.isNotEmpty)
                                                      Text(
                                                        movie.genres
                                                            .take(2)
                                                            .join('  •  '),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppStyles
                                                            .reg16LightGrayRoboto,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (index == moviesList.length - 1)
                                    SizedBox(height: context.width * 0.04),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: context.height * 0.015);
                            },
                            itemCount: moviesList.length,
                          );
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
