import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  int selectedCategory = 0;

  final List<String> categories = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.02,
            vertical: context.height * 0.015,
          ),
          child: Column(
            children: [
              SizedBox(
                height: context.height * 0.055,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: context.width * 0.015,
                    );
                  },
                  itemBuilder: (context, index) {
                    final bool isSelected =
                        selectedCategory == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.035,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.yellowColor : AppColors.transparent,
                          border: Border.all(
                            color: AppColors.yellowColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            context.width * 0.035,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          categories[index],
                          style: isSelected
                              ? AppStyles.reg16BlackRoboto : AppStyles.reg16YellowRoboto,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: context.width * 0.04,
                    mainAxisSpacing: context.height * 0.02,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(
                        context.width * 0.035,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              AppAssets.samMendesImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: context.height * 0.008,
                            left: context.width * 0.02,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                context.width * 0.018,
                                vertical:
                                context.height * 0.004,
                              ),
                              decoration: BoxDecoration(
                                color:
                                AppColors.darkGrayColor,
                                borderRadius:
                                BorderRadius.circular(
                                  context.width * 0.025,
                                ),
                              ),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.min,
                                children: [
                                  Text(
                                    '7.7',
                                    style: AppStyles.reg14YellowRoboto,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color:
                                    AppColors.yellowColor,
                                    size:
                                    context.height * 0.018,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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