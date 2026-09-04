import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

import 'widgets/profile_actions.dart';
import 'widgets/profile_stats.dart';
import 'widgets/profile_watch_list.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: ui.TextDirection.ltr,
            child: Column(
              children: [ProfileStats(), ProfileActions(), ProfileWatchList()],
            ),
          ),
        ),
      ),
    );
  }
}
