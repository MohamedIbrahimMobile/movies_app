import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/api/model/Suggestions.dart';
import 'package:movies_app/ui/similar_movies/similar_movies_widget.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class SimilarMovies extends StatefulWidget {

  SimilarMovies({super.key});
  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Suggestions?>(
        future: DioManager.getSuggestionMovies(50),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return MainLoadingWidget();
          }
          else if(snapshot.hasError){
            return MainErrorWidget(
                errorMessage: snapshot.error.toString(),
                onPressed: () {
                  DioManager.getSuggestionMovies(50);
                  setState(() {

                  });
                },
            );
          }
          else if(!snapshot.hasData || snapshot.data?.status != 'ok'){
            return MainErrorWidget(
                errorMessage: 'Try Again',
                onPressed: (){
                  DioManager.getSuggestionMovies(50);
                  setState(() {

                  });
                }
            );
          }
          else{
            var movies = snapshot.data?.data?.movies ?? [];
            if(movies.isEmpty){
              return Center(
                child: Text('No Movies Found',
                style: AppStyles.bold20WhiteRoboto),
              );
            }
            return  Scaffold(
              backgroundColor: AppColors.blackColor,
              body: SafeArea(
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: context.width*0.06,
                      vertical: context.height*0.04
                  ),
                  child: Column(
                    spacing: context.height*0.04,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('similar'.tr(),
                          style: AppStyles.bold24WhiteRoboto),
                      Expanded(
                        child: GridView.builder(
                          itemBuilder: (context, index) {
                            return SimilarMoviesWidget(
                              movieImage: movies[index].mediumCoverImage ?? '',
                              movieRating: movies[index].rating ?? 0,
                              ratingImage: AppAssets.starIcon,
                            );
                          },
                          itemCount: movies.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.55,
                              mainAxisSpacing: context.height*0.01,
                              crossAxisSpacing: context.width*0.06
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

        },
    );

  }
}
