import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/utils/validators.dart';
import 'package:se7ety/core/widgets/dialog.dart';
import 'package:se7ety/core/widgets/inputs/custom_text_form_field.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';
import 'package:se7ety/features/auth/presentation/widgets/auth_text_action.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userTypeEnum});

  final UserTypeEnum userTypeEnum;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String handleUserType() {
    return widget.userTypeEnum == UserTypeEnum.doctor
        ? "doctor".tr()
        : "patient".tr();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoading(context);
        } else if (state is AuthSuccessState) {
          pop(context);
          if (widget.userTypeEnum == UserTypeEnum.patient) {
            pushAndRemoveUntil(context, Routes.navRoot);
          } else {
            pushAndRemoveUntil(context, Routes.doctorProfileComplete);
          }
        } else if (state is AuthErrorState) {
          pop(context);
          showAppSnackBar(context, state.message, type: DialogType.error);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),

        bottomNavigationBar: AuthTextAction(
          text1: "dont_have_account".tr(),
          text2: "register".tr(),
          onPressed: () {
            pushTo(context, Routes.register, extra: widget.userTypeEnum);
          },
        ),

        body: SafeArea(child: _loginBody()),
      ),
    );
  }

  Widget _loginBody() {
    var cubit = context.read<AuthCubit>();
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Form(
        key: cubit.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(32),

            Image.asset(AppIcons.logo, width: 200, height: 200),

            const Gap(10),

            Text(
              "${"register_as".tr()}${handleUserType()}",
              style: TextStyles.fs20.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

            const Gap(20),

            CustomTextFormField(
              controller: cubit.emailController,
              hintText: "email".tr(),
              validator: Validators().validatorEmail,
              prefixIcon: const Icon(
                Icons.email,
                color: AppColors.primaryColor,
              ),
            ),

            const Gap(10),

            CustomTextFormField(
              controller: cubit.passwordController,
              hintText: "password".tr(),
              validator: Validators().validatorPassword,
              prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
            ),

            const Gap(15),

            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Align(
                alignment: AlignmentGeometry.topRight,
                child: Text("forgot_password".tr(), style: TextStyles.fs14),
              ),
            ),

            const Gap(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MainButton(
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.login();
                  }
                },
                text: "login".tr(),
                borderRadius: 20,
              ),
            ),

            const Gap(20),

            Row(
              children: [
                const Expanded(
                  child: Divider(thickness: 1, indent: 20, endIndent: 10),
                ),
                Text("or".tr()),
                const Expanded(
                  child: Divider(thickness: 1, indent: 10, endIndent: 20),
                ),
              ],
            ),

            const Gap(20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 58),
                  side: const BorderSide(color: AppColors.darkGray),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "google".tr(),
                  style: TextStyles.fs14.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
