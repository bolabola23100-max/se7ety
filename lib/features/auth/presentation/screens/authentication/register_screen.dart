import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/utils/validators.dart';
import 'package:se7ety/core/widgets/custom_back_button.dart';
import 'package:se7ety/core/widgets/inputs/custom_text_form_field.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/core/widgets/inputs/password_text_form_field.dart';
import 'package:se7ety/features/auth/presentation/widgets/auth_text_action.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userTypeEnum});

  final UserTypeEnum userTypeEnum;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String handleUserType() {
    return widget.userTypeEnum == UserTypeEnum.doctor
        ? "doctor".tr()
        : "patient".tr();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(leading: const CustomBackButton()),

      bottomNavigationBar: AuthTextAction(
        text1: "have_account".tr(),
        text2: "login".tr(),
        onPressed: () {
          pushTo(context, Routes.login, extra: widget.userTypeEnum);
        },
      ),

      body: SafeArea(child: _registerBody()),
    );
  }

  Widget _registerBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),

            Image.asset(AppIcons.logo, width: 180, height: 180),

            const Gap(10),

            Text(
              "register_as".tr() + "${handleUserType()}",
              style: TextStyles.fs20.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),

            const Gap(32),

            CustomTextFormField(
              controller: usernameController,
              hintText: 'username'.tr(),
              validator: Validators().validatorName,
              prefixIcon: const Icon(
                Icons.person,
                color: AppColors.primaryColor,
              ),
            ),

            const Gap(15),

            CustomTextFormField(
              controller: emailController,
              hintText: "email".tr(),
              validator: Validators().validatorEmail,
              prefixIcon: const Icon(
                Icons.email,
                color: AppColors.primaryColor,
              ),
            ),

            const Gap(15),

            PasswordTextFormField(
              controller: passwordController,
              text: '********',
              validator: Validators().validatorPassword,
              prefixIcon: const Icon(Icons.lock, color: AppColors.primaryColor),
            ),

            const Gap(30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: MainButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                text: "register".tr(),
                borderRadius: 20,
              ),
            ),

            const Gap(20),
          ],
        ),
      ),
    );
  }
}
