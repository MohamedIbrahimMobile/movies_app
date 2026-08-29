import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/api/model/movie.dart';
import 'package:movies_app/models/my_user.dart';
import 'package:movies_app/services/firestore_service.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileStats extends StatelessWidget {
  ProfileStats({super.key});

  final FirestoreService _firestoreService = FirestoreService();

  final List<String> avatarImageList = [
    AppAssets.avatarImage1,
    AppAssets.avatarImage2,
    AppAssets.avatarImage3,
    AppAssets.avatarImage4,
    AppAssets.avatarImage5,
    AppAssets.avatarImage6,
    AppAssets.avatarImage7,
    AppAssets.avatarImage8,
    AppAssets.avatarImage9,
  ];

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      return SizedBox(
        height: context.height * 0.25,
        child: Center(
          child: Text(
            'User is not logged in.',
            style: AppStyles.reg14WhiteRoboto,
          ),
        ),
      );
    }

    return StreamBuilder<MyUser?>(
      stream: _firestoreService.getUserStream(firebaseUser.uid),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: context.height * 0.25,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            ),
          );
        }

        if (userSnapshot.hasError || !userSnapshot.hasData) {
          return SizedBox(
            height: context.height * 0.25,
            child: Center(
              child: Text(
                userSnapshot.error?.toString() ?? 'Something went wrong.',
                textAlign: TextAlign.center,
                style: AppStyles.reg14WhiteRoboto,
              ),
            ),
          );
        }

        final user = userSnapshot.data!;

        int avatarIndex = user.avatarIndex;

        if (avatarIndex < 0 ||
            avatarIndex >= avatarImageList.length) {
          avatarIndex = 0;
        }

        return Padding(
          padding: EdgeInsets.only(
            left: context.width * 0.035,
            right: context.width * 0.035,
            top: context.height * 0.030,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.transparent,
                      child: ClipOval(
                        child: Image.asset(
                          avatarImageList[avatarIndex],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * 0.015,),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.01,
                      ),
                      child: Text(
                        user.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppStyles.bold20WhiteRoboto.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: StreamBuilder<List<Movie>>(
                  stream: _firestoreService.getWatchList(
                    firebaseUser.uid,
                  ),
                  builder: (context, snapshot) {
                    return _buildStatItem(
                      context,
                      count: snapshot.data?.length ?? 0,
                      title: 'watchlist'.tr(),
                    );
                  },
                ),
              ),

              Expanded(
                flex: 1,
                child: StreamBuilder<List<Movie>>(
                  stream: _firestoreService.getHistory(
                    firebaseUser.uid,
                  ),
                  builder: (context, snapshot) {
                    return _buildStatItem(
                      context,
                      count: snapshot.data?.length ?? 0,
                      title: 'history'.tr(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
      BuildContext context, {
        required int count,
        required String title,
      }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$count',
          style: AppStyles.bold24WhiteRoboto,
        ),
        SizedBox(height: context.height * 0.01,),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.bold20WhiteRoboto.copyWith(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}