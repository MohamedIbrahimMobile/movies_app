import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/auth/auth_bloc.dart';
import 'package:movies_app/blocs/auth/auth_event.dart';
import 'package:movies_app/blocs/auth/auth_state.dart';
import 'package:movies_app/data/repositories/auth_repository.dart';
import 'package:movies_app/ui/home/tabs/profile/widgets/bottom_sheet_item.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

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

  int selectedIndex = 0;
  bool isLoading = true;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AuthBloc(authRepository: AuthRepository())..add(LoadProfileEvent()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            nameController.text = state.user.name;
            phoneController.text = state.user.phone;
            if (state.user.avatarIndex >= 0 &&
                state.user.avatarIndex < avatarImageList.length) {
              selectedIndex = state.user.avatarIndex;
            }
            setState(() {
              isLoading = false;
            });
          }
          if (state is UpdateProfileSuccess) {
            DialogUtils.showSuccessToast(
              message: 'profile_updated_success'.tr(),
            );
            Navigator.pop(context);
          }
          if (state is DeleteAccountSuccess) {
            DialogUtils.showSuccessToast(
              message: 'account_deleted_success'.tr(),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.loginRouteName,
              (route) => false,
            );
          }
          if (state is AuthError) {
            setState(() {
              isLoading = false;
            });
            DialogUtils.showMessage(
              context: context,
              message: state.message,
              posActionName: 'ok'.tr(),
            );
          }
        },
        builder: (context, state) {
          final isUpdating = state is AuthLoading && !isLoading;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'pick_avatar'.tr(),
                style: AppStyles.reg16YellowRoboto,
              ),
              centerTitle: true,
            ),
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.width * 0.037,
                    ),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
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
                            key: formKey,
                            child: Column(
                              spacing: context.height * 0.024,
                              children: [
                                CustomTextField(
                                  controller: nameController,
                                  hintText: 'name'.tr(),
                                  prefixIcon: Image.asset(
                                    AppAssets.personIcon,
                                    color: AppColors.whiteColor,
                                  ),
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return 'please_enter_name'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  controller: phoneController,
                                  hintText: 'phone_number'.tr(),
                                  prefixIcon: Image.asset(
                                    AppAssets.phoneIcon,
                                    color: AppColors.whiteColor,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (text) {
                                    if (text == null || text.trim().isEmpty) {
                                      return 'please_enter_phone_number'.tr();
                                    }
                                    final phoneValid = RegExp(r'^[0-9]+$')
                                        .hasMatch(text.trim());
                                    if (!phoneValid) {
                                      return 'please_enter_numbers_only'.tr();
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.forgetPasswordRouteName,
                                );
                              },
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
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.redColor,
                        radius: 10,
                        verticalPadding: context.height * 0.015,
                        onPressed: isUpdating
                            ? () {}
                            : () {
                                confirmDelete(context);
                              },
                        child: Text(
                          'delete_account'.tr(),
                          style: AppStyles.reg16WhiteRoboto,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        backgroundColor: AppColors.yellowColor,
                        radius: 10,
                        verticalPadding: context.height * 0.015,
                        onPressed: isUpdating
                            ? () {}
                            : () {
                                updateAccount(context);
                              },
                        child: isUpdating
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                ),
                              )
                            : Text(
                                'update_data'.tr(),
                                style: AppStyles.reg16BlackRoboto,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void confirmDelete(BuildContext innerContext) {
    DialogUtils.showMessage(
      context: innerContext,
      title: 'delete_account_title'.tr(),
      message: 'delete_account_confirm_message'.tr(),
      posActionName: 'delete'.tr(),
      posAction: () {
        innerContext.read<AuthBloc>().add(DeleteAccountEvent());
      },
      negActionName: 'cancel'.tr(),
    );
  }

  void updateAccount(BuildContext innerContext) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    innerContext.read<AuthBloc>().add(
      UpdateProfileEvent(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        avatarIndex: selectedIndex,
      ),
    );
  }

  void buildBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      builder: (bottomSheetContext) {
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
                      Navigator.pop(bottomSheetContext);
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
}
