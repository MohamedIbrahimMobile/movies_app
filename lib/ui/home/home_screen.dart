import 'package:flutter/material.dart';
import 'package:movies_app/ui/home/tabs/browse/browse_tab.dart';
import 'package:movies_app/ui/home/tabs/home/home_tab.dart';
import 'package:movies_app/ui/home/tabs/profile/profile_tab.dart';
import 'package:movies_app/ui/home/tabs/search/search_tab.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabsList = [
    HomeTab(), SearchTab(),
    BrowseTab(),ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabsList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.darkGrayColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.yellowColor,
        unselectedItemColor: AppColors.lightGrayColor,

        selectedIconTheme: IconThemeData(
          color: AppColors.yellowColor,
          size: context.height * 0.027,
        ),
        unselectedIconTheme: IconThemeData(
          color: AppColors.lightGrayColor,
          size: context.height * 0.027,
        ),
        items: [
          buildBottomNavigationBarItem(
            icon: AppAssets.homeIcon,
          ),
          buildBottomNavigationBarItem(
            icon: AppAssets.searchIcon,
          ),
          buildBottomNavigationBarItem(
            icon: AppAssets.browseIcon,
          ),
          buildBottomNavigationBarItem(
            icon: AppAssets.profileIcon,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String icon,
  })
  {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(icon),
        size: context.height * 0.027,
      ),
      label: '',
    );
  }
}