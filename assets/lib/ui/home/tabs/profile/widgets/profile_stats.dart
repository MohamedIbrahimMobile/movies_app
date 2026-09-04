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
import 'package:movies_app/widgets/main_error_widget.dart';
import 'package:movies_app/widgets/main_loading_widget.dart';

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

    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.06,
        right: context.width * 0.012,
        top: context.height * 0.030,
        bottom: context.height * 0.005,
      ),
      child: StreamBuilder<MyUser?>(
        stream: _firestoreService.getUserStream(firebaseUser!.uid),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return MainLoadingWidget(height: context.height * 0.25);
          }

          if (userSnapshot.hasError) {
            return MainErrorWidget(
              height: context.height * 0.25,
              message: userSnapshot.error.toString().replaceFirst(
                'Exception: ',
                '',
              ),
              onPressed: () {},
            );
          }

          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return MainErrorWidget(
              height: context.height * 0.25,
              message: 'No user data available.',
              onPressed: () {},
            );
          }

          final user = userSnapshot.data!;

          int avatarIndex = user.avatarIndex;

          if (avatarIndex < 0 || avatarIndex >= avatarImageList.length) {
            avatarIndex = 0;
          }

          return Row(
            spacing: context.width * 0.012,
            children: [
              Expanded(
                child: Column(
                  spacing: context.height * 0.015,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 53,
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
                    Text(
                      user.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppStyles.bold20WhiteRoboto,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.width * 0.05),
              Expanded(
                child: StreamBuilder<List<Movie>>(
                  stream: _firestoreService.getWatchList(firebaseUser.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const MainLoadingWidget();
                    }

                    if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    }

                    return _buildStatItem(
                      context,
                      count: snapshot.data?.length ?? 0,
                      title: 'watch_list'.tr(),
                    );
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<List<Movie>>(
                  stream: _firestoreService.getHistory(firebaseUser.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const MainLoadingWidget();
                    }

                    if (snapshot.hasError) {
                      return const SizedBox.shrink();
                    }

                    return _buildStatItem(
                      context,
                      count: snapshot.data?.length ?? 0,
                      title: 'history'.tr(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
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
          style: AppStyles.bold20WhiteRoboto.copyWith(fontSize: 28),
        ),
        SizedBox(height: context.height * 0.01),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: AppStyles.reg18WhiteRoboto,
        ),
      ],
    );
  }
}
