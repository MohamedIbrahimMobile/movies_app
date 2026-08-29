import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/services/firestore_service.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileWatchList extends StatefulWidget {
  const ProfileWatchList({super.key});

  @override
  State<ProfileWatchList> createState() => _ProfileWatchListState();
}

class _ProfileWatchListState extends State<ProfileWatchList> {
  final FirestoreService _firestoreService = FirestoreService();

  int selectedIndex = 0;

  String? get _userId {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Stream<List<Movie>> _getMoviesStream() {
    final userId = _userId;

    if (userId == null) {
      return Stream.error(
        Exception('User is not logged in.'),
      );
    }

    if (selectedIndex == 0) {
      return _firestoreService.getWatchList(userId);
    }

    return _firestoreService.getHistory(userId);
  }

  void _changeTab(int index) {
    if (selectedIndex == index) {
      return;
    }

    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.height * 0.025,),
        Row(
          children: [
            Expanded(
              child: _buildTab(
                context,
                icon: Icons.list,
                title: 'watchlist'.tr(),
                index: 0,
              ),
            ),
            Expanded(
              child: _buildTab(
                context,
                icon: Icons.folder,
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
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.height * 0.12,
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return _buildError();
            }

            final movies = snapshot.data ?? [];

            if (movies.isEmpty) {
              return _buildEmptyState();
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: context.width * 0.03,
                right: context.width * 0.03,
                top: context.height * 0.025,
                bottom: context.height * 0.02,
              ),
              itemCount: movies.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: context.width * 0.025,
                mainAxisSpacing: context.height * 0.018,
                childAspectRatio: 0.57,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];

                return _buildMovieCard(
                  context, movie,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildMovieCard(
      BuildContext context,
      Movie movie,
      ) {
    return GestureDetector(
      onTap: () {
        final movieId = movie.id;

        if (movieId == null) {
          return;
        }

        Navigator.pushNamed(
          context,
          AppRoutes.movieDetailsScreenRouteName,
          arguments: movieId,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.mediumCoverImage ?? '',
              fit: BoxFit.cover,
              errorBuilder: (
                  context, error, stackTrace,
                  ) {
                return Container(
                  color: AppColors.darkGrayColor,
                  child: Icon(
                    Icons.movie,
                    color: AppColors.whiteColor,
                  ),
                );
              },
            ),

            Positioned(
              top: context.height * 0.008,
              left: context.width * 0.008,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.015,
                  vertical: context.height * 0.004,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGrayColor.withValues(
                    alpha: 0.85,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${movie.rating ?? 0.0}',
                      style: AppStyles.reg14WhiteRoboto,
                    ),
                    SizedBox(width: context.width * 0.008,),
                    Image.asset(
                      AppAssets.starIcon,
                      width: context.width * 0.035,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.height * 0.12,
      ),
      child: Center(
        child: Image.asset(
          AppAssets.watchListImage,
          width: context.width * 0.25,
        ),
      ),
    );
  }

  Widget _buildError() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.height * 0.08,
        horizontal: context.width * 0.06,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: context.height * 0.02,
        children: [
          Text(
            'Something went wrong.',
            textAlign: TextAlign.center,
            style: AppStyles.reg14WhiteRoboto,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.yellowColor,
            ),
            child: Text(
              'Try Again'.tr(),
              style: AppStyles.reg16WhiteRoboto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
      BuildContext context, {
        required IconData icon,
        required String title,
        required int index,
      }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => _changeTab(index),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.yellowColor
                : AppColors.whiteColor,
            size: context.height * 0.028,
          ),
          SizedBox(height: context.height * 0.005,),
          Text(
            title,
            style: AppStyles.reg14WhiteRoboto,
          ),
          SizedBox(height: context.height * 0.008,),
          Container(
            height: context.height * 0.003,
            width: double.infinity,
            color: isSelected
                ? AppColors.yellowColor
                : AppColors.transparent,
          ),
        ],
      ),
    );
  }
}