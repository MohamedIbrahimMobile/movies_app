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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authRepository: AuthRepository(),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess || state is GoogleLoginSuccess) {
            DialogUtils.showSuccessToast(
              message: 'logged_in_success'.tr(),
            );
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.homeRouteName,
            );
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
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.02,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          AppAssets.loginImage,
                          height: context.height * 0.3,
                        ),
                        CustomTextField(
                          controller: emailController,
                          prefixIcon: Image.asset(
                            AppAssets.emailIcon,
                          ),
                          fillColor: AppColors.darkGrayColor,
                          fill: true,
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
                        SizedBox(
                          height: context.height * 0.03,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          prefixIcon: Image.asset(
                            AppAssets.passwordIcon,
                          ),
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
                          fillColor: AppColors.darkGrayColor,
                          fill: true,
                          obscureText: isPasswordObscured,
                          hintText: 'password'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_enter_password'.tr();
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.forgetPasswordRouteName,
                                );
                              },
                              child: Text(
                                'forgot_password'.tr(),
                                style: AppStyles.reg14YellowRoboto,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.025,
                        ),
                        CustomElevatedButton(
                          verticalPadding: context.height * 0.017,
                          backgroundColor: AppColors.yellowColor,
                          onPressed: () {
                            if (isLoading) {
                              return;
                            }
                            login(context);
                          },
                          child: isLoading
                              ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: AppColors.blackColor,
                            ),
                          )
                              : Text(
                            'login'.tr(),
                            style: AppStyles.reg20BlackRoboto,
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'dont_have_account'.tr(),
                              style: AppStyles.reg14WhiteRoboto,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.registerRouteName,
                                );
                              },
                              child: Text(
                                'create'.tr(),
                                style: AppStyles.reg14YellowRoboto,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.015,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.yellowColor,
                                thickness: 2,
                                indent: context.width * 0.18,
                                endIndent: context.width * 0.04,
                              ),
                            ),
                            Text(
                              'or'.tr(),
                              style: AppStyles.reg15YellowRoboto,
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.yellowColor,
                                thickness: 2,
                                indent: context.width * 0.04,
                                endIndent: context.width * 0.18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: context.height * 0.04,
                        ),
                        CustomElevatedButton(
                          verticalPadding: context.height * 0.017,
                          backgroundColor: AppColors.yellowColor,
                          onPressed: () {
                            if (isLoading) {
                              return;
                            }
                            context.read<AuthBloc>().add(
                              GoogleLoginEvent(),
                            );
                          },
                          child: Row(
                            spacing: context.width * 0.03,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.googleIcon,
                              ),
                              Text(
                                'login_google'.tr(),
                                style: AppStyles.reg16BlackRoboto,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: context.height * 0.04,
                        ),
                        const LanguageToggleSwitch(),
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

  void login(BuildContext context) {
    if (formKey.currentState?.validate() != true) {
      return;
    }
    context.read<AuthBloc>().add(
      LoginEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }
}