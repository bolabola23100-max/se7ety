import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/services/firebase/failure.dart';
import 'package:se7ety/features/auth/data/model/auth_prams.dart';
import 'package:se7ety/features/auth/data/repo/auth_repo.dart';
import 'auth_state.dart';
import 'package:flutter/material.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
}
