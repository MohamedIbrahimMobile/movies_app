import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/blocs/auth/auth_bloc.dart';
import 'package:movies_app/blocs/auth/auth_event.dart';
import 'package:movies_app/blocs/auth/auth_state.dart';
import 'package:movies_app/data/repositories/auth_repository.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/dialog_utils.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/widgets/custom_elevated_button.dart';
import 'package:movies_app/widgets/custom_text_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository: AuthRepository()),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            DialogUtils.showToast(message: 'password_reset_sent'.tr());
            Navigator.pop(context);
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
              title: Text(
                'forget_password_title'.tr(),
                style: AppStyles.reg16YellowRoboto,
              ),
            ),
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
                        Image.asset(AppAssets.forgetPasswordImage),
                        SizedBox(height: context.height * 0.04),
                        CustomTextField(
                          controller: emailController,
                          fillColor: AppColors.darkGrayColor,
                          fill: true,
                          prefixIcon: Image.asset(AppAssets.emailIcon),
                          hintText: 'email'.tr(),
                          hintStyle: AppStyles.reg16WhiteRoboto,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please_enter_email'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.height * 0.03),
                        CustomElevatedButton(
                          verticalPadding: context.height * 0.013,
                          backgroundColor: AppColors.yellowColor,
                          onPressed: isLoading
                              ? () {}
                              : () {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  context.read<AuthBloc>().add(
                                    ForgetPasswordEvent(
                                      email: emailController.text.trim(),
                                    ),
                                  );
                                },
                          child: isLoading
                              ? SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: AppColors.blackColor,
                                  ),
                                )
                              : Text(
                                  'verify'.tr(),
                                  style: AppStyles.reg20BlackRoboto,
                                ),
                        ),
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
}
