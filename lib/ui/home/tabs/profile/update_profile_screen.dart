import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/ui/home/tabs/profile/widgets/bottom_sheet_item.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int selectedIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'pick_avatar'.tr(),
          style: AppStyles.reg16YellowRoboto,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.037,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: context.height * 0.024,
            children: [
              GestureDetector(
                onTap: buildBottomSheet,
                child: Container(
                  margin: EdgeInsets.only(
                    top: context.height * 0.043,
                    bottom: context.height * 0.017,
                  ),
                  width: context.width * 0.4,
                  height: context.height * 0.18,
                  child: Image.asset(
                    avatarImageList[selectedIndex],
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              Form(
                child: Column(
                  spacing: context.height * 0.024,
                  children: [
                    CustomTextField(
                      hintText: 'name',
                      prefixIcon: Image.asset(
                        AppAssets.personIcon,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    CustomTextField(
                      hintText: 'phone',
                      prefixIcon: Image.asset(
                        AppAssets.phoneIcon,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: AlignmentDirectional.centerStart,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'reset_password'.tr(),
                    style: AppStyles.reg20WhiteRoboto,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.037,
          ),
          child: Column(
            spacing: context.height * 0.016,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomElevatedButton(
                onPressed: deleteAccount,
                backgroundColor: AppColors.redColor,
                child: Text(
                  'delete_account'.tr(),
                  style: AppStyles.reg20WhiteRoboto,
                ),
              ),

              CustomElevatedButton(
                onPressed: updateAccount,
                backgroundColor: AppColors.yellowColor,
                child: Text(
                  'update_data'.tr(),
                  style: AppStyles.reg20BlackRoboto,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buildBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: context.width * 0.037,
              right: context.width * 0.037,
              bottom: context.height * 0.006,
            ),
            child: Container(
              height: context.height * 0.44,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.darkGrayColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 15,
                ),
                itemCount: avatarImageList.length,
                itemBuilder: (context, index) {
                  return BottomSheetItem(
                    avatarImageList: avatarImageList,
                    currentIndex: index,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  void deleteAccount() {}

  void updateAccount() {}
}