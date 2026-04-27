import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/services/firebase/failure.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/features/auth/data/model/auth_prams.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/data/repo/auth_repo.dart';
import 'auth_state.dart';
import 'package:flutter/material.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final openHourController = TextEditingController();
  final closeHourController = TextEditingController();
  final addressController = TextEditingController();

  String? specialization;
  File? imageFile;

  Future<void> login() async {
    emit(AuthLoadingState());

    var data = await AuthRepo.login(
      authPrams: AuthPrams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    data.fold(
      (failure) {
        emit(AuthErrorState(message: failure.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> register(UserTypeEnum userTypeEnum) async {
    emit(AuthLoadingState());
    var authPrams = AuthPrams(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    Either<Failure, Unit> result;
    if (userTypeEnum == UserTypeEnum.doctor) {
      result = await AuthRepo.registerDoctor(authPrams: authPrams);
    } else {
      result = await AuthRepo.registerPatient(authPrams: authPrams);
    }
    result.fold(
      (failure) {
        emit(AuthErrorState(message: failure.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> updateDoctor() async {
    emit(AuthLoadingState());
    var doctor = DoctorModel(
      bio: bioController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      openHour: openHourController.text,
      closeHour: closeHourController.text,
      address: addressController.text,
      specialization: specialization,
      uid: SharedPref.getUserId(),
      image: imageFile,
    );
    var data = await AuthRepo.updateDoctorProfile(doctor);
    data.fold(
      (failure) {
        emit(AuthErrorState(message: failure.message));
      },
      (r) {
        emit(AuthSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    phone1Controller.dispose();
    phone2Controller.dispose();
    openHourController.dispose();
    closeHourController.dispose();
    addressController.dispose();
    return super.close();
  }
}
