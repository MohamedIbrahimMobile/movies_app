import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileWatchList extends StatefulWidget {
  const ProfileWatchList({super.key});

  @override
  State<ProfileWatchList> createState() => _ProfileWatchListState();
}

class _ProfileWatchListState extends State<ProfileWatchList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: context.height * 0.025,
          ),

          // Tabs
          Row(
            children: [
              Expanded(
                child: _buildTab(
                  context,
                  icon: Icons.list,
                  title: 'Watch List',
                  index: 0,
                ),
              ),

              Expanded(
                child: _buildTab(
                  context,
                  icon: Icons.folder,
                  title: 'History',
                  index: 1,
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: Center(
              child: Image.asset(
                AppAssets.watchListImage,
                width: context.width * 0.25,
              ),
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
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected
                ? AppColors.yellowColor
                : AppColors.whiteColor,
            size: context.height * 0.028,
          ),

          SizedBox(
            height: context.height * 0.005,
          ),

          Text(
            title,
            style: AppStyles.reg14WhiteRoboto,
          ),

          SizedBox(
            height: context.height * 0.008,
          ),

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