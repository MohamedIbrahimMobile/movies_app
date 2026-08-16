import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/custom_widgets/update_profile/bottom_sheet_item.dart';
import 'package:movies_app/custom_widgets/update_profile/custom_btn.dart';
import 'package:movies_app/custom_widgets/update_profile/custom_text_form_field.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int selectedIndex = 0;

  List<String> avatarImageList = [
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
        title: Text('pick_avatar'.tr(), style: AppStyles.reg16YellowRoboto),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.037),
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
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Form(
                child: Column(
                  spacing: context.height * 0.024,
                  children: [
                    CustomTextFormField(
                      text: 'name',
                      icon: AppAssets.personIcon,
                    ),
                    CustomTextFormField(
                      text: 'phone',
                      icon: AppAssets.phoneIcon,
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
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.037),
          child: Column(
            spacing: context.height * 0.016,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBtn(
                text: 'delete_account',
                textStyle: AppStyles.reg20WhiteRoboto,
                background: AppColors.redColor,
                onTap: deleteAccount,
              ),
              CustomBtn(
                text: 'update_data',
                textStyle: AppStyles.reg20BlackRoboto,
                background: AppColors.yellowColor,
                onTap: updateAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void buildBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
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
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.darkGrayColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: context.height * 0.023,
                  crossAxisSpacing: context.width * 0.043,
                ),
                itemBuilder: (context, index) {
                  return BottomSheetItem(
                    avatarImageList: avatarImageList,
                    currentIndex: index,
                    onTap: () {
                      selectedIndex = index;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    selectedIndex: selectedIndex,
                  );
                },
                itemCount: 9,
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
