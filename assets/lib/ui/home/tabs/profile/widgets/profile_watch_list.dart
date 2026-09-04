import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/services/firestore_service.dart';
import 'package:movies_app/ui/home/tabs/home/widgets/movie_card.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

class ProfileWatchList extends StatefulWidget {
  const ProfileWatchList({super.key});

  @override
  State<ProfileWatchList> createState() => _ProfileWatchListState();
}

class _ProfileWatchListState extends State<ProfileWatchList> {
  final FirestoreService _firestoreService = FirestoreService();

  int selectedIndex = 0;

  Stream<List<Movie>> _getMoviesStream() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (selectedIndex == 0) {
      return _firestoreService.getWatchList(userId!);
    }

    return _firestoreService.getHistory(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height * 0.03),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildTab(
                context,
                icon: AppAssets.listIcon,
                title: 'watch_list'.tr(),
                index: 0,
              ),
            ),
            Expanded(
              child: _buildTab(
                context,
                icon: AppAssets.fileIcon,
                title: 'history'.tr(),
                index: 1,
              ),
            ),
          ],
        ),

        StreamBuilder<List<Movie>>(
          stream: _getMoviesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MainLoadingWidget(height: context.height * 0.43);
            }

            if (snapshot.hasError) {
              return MainErrorWidget(
                height: context.height * 0.43,
                message: snapshot.error.toString().replaceFirst(
                  'Exception: ',
                  '',
                ),
                onPressed: () {
                  setState(() {});
                },
              );
            }

            final movies = snapshot.data ?? [];

            if (movies.isEmpty) {
              return SizedBox(
                height: context.height * 0.43,
                child: Image.asset(AppAssets.watchListImage),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: context.width * 0.03,
                right: context.width * 0.03,
                top: context.height * 0.022,
                bottom: context.height * 0.02,
              ),
              itemCount: movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: context.width * 0.025,
                mainAxisSpacing: context.height * 0.015,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: movies[index],
                  verticalMargin: context.height * 0.0057,
                  horizontalMargin: context.width * 0.013,
                  radius: 15,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String icon,
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return InkWell(
      overlayColor: WidgetStateProperty.all(AppColors.transparent),
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        if (selectedIndex == index) {
          return;
        }
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        spacing: context.height * 0.01,
        children: [
          Image.asset(
            icon,
            color: isSelected ? AppColors.yellowColor : AppColors.whiteColor,
            width: context.height * 0.028,
          ),
          Text(title, style: AppStyles.reg14WhiteRoboto),
          Container(
            height: context.height * 0.003,
            color: isSelected ? AppColors.yellowColor : AppColors.transparent,
          ),
        ],
      ),
    );
  }
}
