import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/core/constants/app_icons.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/styles/colors.dart';
import 'package:se7ety/core/styles/text_styles.dart';
import 'package:se7ety/core/utils/navigations.dart';
import 'package:se7ety/core/widgets/dialog.dart';
import 'package:se7ety/core/widgets/inputs/custom_text_form_field.dart';
import 'package:se7ety/core/widgets/inputs/main_button.dart';
import 'package:se7ety/features/auth/data/model/specializations.dart';

import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class DoctorProfileCompleteView extends StatefulWidget {
  const DoctorProfileCompleteView({super.key});

  @override
  State<DoctorProfileCompleteView> createState() =>
      _DoctorProfileCompleteViewState();
}

class _DoctorProfileCompleteViewState extends State<DoctorProfileCompleteView> {
  String? _imagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        context.read<AuthCubit>().imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoading(context);
        } else if (state is AuthSuccessState) {
          pop(context);
          pushReplacement(context, Routes.navRoot);
        } else if (state is AuthErrorState) {
          pop(context);
          showAppSnackBar(context, state.message, type: DialogType.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'إكمال عملية التسجيل',
            style: TextStyles.fs20.copyWith(color: AppColors.lightGray),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CircleAvatar(
                            radius: 50,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.bgColor,
                              backgroundImage: (_imagePath != null)
                                  ? FileImage(File(_imagePath!))
                                  : const AssetImage(AppIcons.doc),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'التخصص',
                            style: TextStyles.fs14.copyWith(
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButton<String?>(
                          isExpanded: true,
                          iconEnabledColor: AppColors.primaryColor,
                          hint: Text(
                            'اختر التخصص',
                            style: TextStyles.fs14.copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                          icon: const Icon(Icons.expand_circle_down_outlined),
                          value: cubit.specialization,
                          onChanged: (String? newValue) {
                            setState(() {
                              cubit.specialization = newValue;
                            });
                          },
                          items: [
                            for (var specialization in specializations)
                              DropdownMenuItem(
                                value: specialization,
                                child: Text(specialization),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 9,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'نبذة تعريفية',
                            style: TextStyles.fs14.copyWith(
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextFormField(
                      controller: cubit.bioController,
                      maxLines: 4,
                      hintText:
                          'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي وخبراتك السابقة...',

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل النبذة التعريفية';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 9,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'عنوان العيادة',
                            style: TextStyles.fs14.copyWith(
                              color: AppColors.dark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomTextFormField(
                      controller: cubit.addressController,
                      hintText: '5 شارع مصدق - الدقي - الجيزة',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل عنوان العيادة';
                        } else {
                          return null;
                        }
                      },
                    ),
                    _workHours(cubit),
                    _phoneNumbers(cubit),
                  ],
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: MainButton(
            onPressed: () async {
              if (cubit.formKey.currentState!.validate()) {
                if (cubit.imageFile != null) {
                  cubit.updateDoctor();
                } else {
                  showAppSnackBar(context, "Please choose profile image");
                }
              }
            },
            text: "التسجيل",
          ),
        ),
      ),
    );
  }

  Column _workHours(AuthCubit bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 9,
                ),
                child: Row(
                  children: [
                    Text(
                      'ساعات العمل من',
                      style: TextStyles.fs14.copyWith(color: AppColors.dark),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 9,
                ),
                child: Row(
                  children: [
                    Text(
                      'الي',
                      style: TextStyles.fs14.copyWith(color: AppColors.dark),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                readOnly: true,
                controller: bloc.openHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showStartTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: CustomTextFormField(
                readOnly: true,
                controller: bloc.closeHourController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'مطلوب';
                  } else {
                    return null;
                  }
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    await showEndTimePicker(bloc);
                  },
                  icon: const Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                hintText: '00:00',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _phoneNumbers(AuthCubit bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 1',
                style: TextStyles.fs14.copyWith(color: AppColors.dark),
              ),
            ],
          ),
        ),
        CustomTextFormField(
          controller: bloc.phone1Controller,
          keyboardType: TextInputType.phone,
          hintText: '+20xxxxxxxxxx',
          validator: (value) {
            if (value!.isEmpty) {
              return 'من فضلك ادخل الرقم';
            } else {
              return null;
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          child: Row(
            children: [
              Text(
                'رقم الهاتف 2 (اختياري)',
                style: TextStyles.fs14.copyWith(color: AppColors.dark),
              ),
            ],
          ),
        ),
        CustomTextFormField(
          controller: bloc.phone2Controller,
          keyboardType: TextInputType.phone,
          hintText: '+20xxxxxxxxxx',
        ),
      ],
    );
  }

  Future<void> showStartTimePicker(AuthCubit cubit) async {
    final startTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTimePicked != null) {
      cubit.openHourController.text = startTimePicked.format(context);
    }
  }

  Future<void> showEndTimePicker(AuthCubit cubit) async {
    final endTimePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );

    if (endTimePicked != null) {
      cubit.closeHourController.text = endTimePicked.format(context);
    }
  }
}
