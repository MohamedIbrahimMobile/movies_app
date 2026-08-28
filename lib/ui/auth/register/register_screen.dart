import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/auth/auth_bloc.dart';
import 'package:movies_app/blocs/auth/auth_event.dart';
import 'package:movies_app/blocs/auth/auth_state.dart';
import 'package:movies_app/data/repositories/auth_repository.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';
import 'package:movies_app/widgets/language_toggle_switch.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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

  int selectedAvatarIndex = 0;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: AuthRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            DialogUtils.showSuccessToast(
              message: 'account_created_success'.tr(),
            );
            Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
          }
          if (state is AuthError) {
            DialogUtils.showMessage(
              context: context,
              message: state.message,
              posActionName: 'ok'.tr(),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text('register'.tr(), style: AppStyles.reg16YellowRoboto),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.04,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: avatarImageList.length,
                          options: CarouselOptions(
                            height: context.height * 0.20,
                            viewportFraction: 0.32,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.35,
                            enableInfiniteScroll: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                selectedAvatarIndex = index;
                              });
                            },
                          ),
                          itemBuilder: (context, index, realIndex) {
                            final isSelected = index == selectedAvatarIndex;
                            return AnimatedScale(
                              scale: isSelected ? 1.15 : 0.85,
                              duration: const Duration(milliseconds: 250),
                              child: Image.asset(
                                avatarImageList[index],
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                        Text(
                          'avatar'.tr(),
                          textAlign: TextAlign.center,
                          style: AppStyles.reg16WhiteRoboto,
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextField(
                          controller: nameController,
                          prefixIcon: Image.asset(AppAssets.nameIcon),
                          hintText: 'name'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_enter_name'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextField(
                          controller: emailController,
                          prefixIcon: Image.asset(AppAssets.emailIcon),
                          hintText: 'email'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_enter_email'.tr();
                            }
                            final emailValid = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(text.trim());
                            if (!emailValid) {
                              return 'please_enter_valid_email'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextField(
                          controller: passwordController,
                          prefixIcon: Image.asset(AppAssets.passwordIcon),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.whiteColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordObscured = !isPasswordObscured;
                              });
                            },
                          ),
                          hintText: 'password'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          obscureText: isPasswordObscured,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_enter_password'.tr();
                            }
                            if (text.length < 6) {
                              return 'password_min_length'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextField(
                          controller: confirmPasswordController,
                          prefixIcon: Image.asset(AppAssets.passwordIcon),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isConfirmPasswordObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.whiteColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordObscured =
                                    !isConfirmPasswordObscured;
                              });
                            },
                          ),
                          hintText: 'confirm_password'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          obscureText: isConfirmPasswordObscured,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_confirm_password'.tr();
                            }
                            if (text != passwordController.text) {
                              return 'passwords_dont_match'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.height * 0.02),
                        CustomTextField(
                          controller: phoneController,
                          prefixIcon: Image.asset(AppAssets.phoneIcon),
                          hintText: 'phone_number'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          keyboardType: TextInputType.phone,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_enter_phone_number'.tr();
                            }
                            final cleanText = text.trim();
                            final phoneValid = RegExp(r'^[0-9]+$')
                                .hasMatch(cleanText);
                            if (!phoneValid) {
                              return 'please_enter_numbers_only'.tr();
                            }
                            final egyptianPhoneValid = RegExp(
                              r'^01[0125][0-9]{8}$',
                            ).hasMatch(cleanText);
                            if (!egyptianPhoneValid) {
                              return 'invalid_phone_number'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.height * 0.025),
                        CustomElevatedButton(
                          verticalPadding: context.height * 0.014,
                          backgroundColor: AppColors.yellowColor,
                          onPressed: () {
                            if (isLoading) {
                              return;
                            }
                            register(context);
                          },
                          child: isLoading
                              ? Container(
                                  alignment: Alignment.center,
                                  height: context.height * 0.035,
                                  child: SizedBox(
                                    height: context.height * 0.027,
                                    width: context.width * 0.06,
                                    child: CircularProgressIndicator(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'create_account'.tr(),
                                    style: AppStyles.reg20BlackRoboto,
                                  ),
                                ),
                        ),
                        SizedBox(height: context.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already_have_account'.tr(),
                              style: AppStyles.reg14WhiteRoboto,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                  context,
                                  AppRoutes.loginRouteName,
                                );
                              },
                              child: Text(
                                'login'.tr(),
                                style: AppStyles.reg14YellowRoboto,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: context.height * 0.01),
                        const LanguageToggleSwitch(),
                        SizedBox(height: context.height * 0.04),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void register(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(
      RegisterEvent(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
        avatarIndex: selectedAvatarIndex,
      ),
    );
  }
}
