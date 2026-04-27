import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:se7ety/core/constants/user_type_enum.dart';
import 'package:se7ety/core/services/firebase/failure.dart';
import 'package:se7ety/core/services/firebase/firebase_provider.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/image_uploader.dart';
import 'package:se7ety/features/auth/data/model/auth_prams.dart';
import 'package:se7ety/features/auth/data/model/doctor_model.dart';
import 'package:se7ety/features/auth/data/model/patient_model.dart';

abstract class AuthRepo {
  static Future<Either<Failure, UserTypeEnum>> login({
    required AuthPrams authPrams,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authPrams.email,
        password: authPrams.password,
      );
      await SharedPref.cacheUserId(credential.user?.uid ?? '');
      if (credential.user?.photoURL == 'Doctor') {
        return right(UserTypeEnum.doctor);
      } else {
        return right(UserTypeEnum.patient);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(Failure(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return left(Failure(message: 'Wrong password provided for that user.'));
      } else {
        return left(Failure(message: 'حدث خطأ '));
      }
    } catch (e) {
      return left(Failure(message: 'حدث خطأ'));
    }
  }

  static Future<Either<Failure, Unit>> registerDoctor({
    required AuthPrams authPrams,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: authPrams.email,
            password: authPrams.password,
          );
      log("User created in FirebaseAuth");
      await credential.user?.updateDisplayName(authPrams.name);
      await credential.user?.updatePhotoURL('Doctor');
      log("User profile updated");
      await SharedPref.cacheUserId(credential.user?.uid ?? '');
      var doctorData = DoctorModel(
        name: authPrams.name,
        email: authPrams.email,
        uid: credential.user?.uid,
      );
      log("Adding doctor to Firestore");
      await FirebaseProvider.addDoctor(doctorData);
      log("Doctor added to Firestore");
      return right(unit);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code}");
      if (e.code == 'weak-password') {
        return left(Failure(message: 'كلمة السر ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(message: 'البريد الالكتروني موجود بالفعل'));
      } else {
        return left(Failure(message: 'حدث خطأ '));
      }
    } catch (e) {
      return left(Failure(message: 'حدث خطأ'));
    }
  }

  static Future<Either<Failure, Unit>> registerPatient({
    required AuthPrams authPrams,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: authPrams.email,
            password: authPrams.password,
          );

      log("User created in FirebaseAuth (Patient)");
      await credential.user?.updateDisplayName(authPrams.name);
      await credential.user?.updatePhotoURL('Patient');
      log("User profile updated");
      await SharedPref.cacheUserId(credential.user?.uid ?? '');
      var patientData = PatientModel(
        name: authPrams.name,
        email: authPrams.email,
        uid: credential.user?.uid,
      );
      log("Adding patient to Firestore");
      await FirebaseProvider.addPatient(patientData);
      log("Patient added to Firestore");
      return right(unit);
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code}");
      if (e.code == 'weak-password') {
        return left(Failure(message: 'كلمة السر ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        return left(Failure(message: 'البريد الالكتروني موجود بالفعل'));
      } else {
        return left(Failure(message: 'حدث خطأ '));
      }
    } catch (e, stackTrace) {
      log("REAL ERROR: $e");
      log("STACK: $stackTrace");
      return left(Failure(message: e.toString()));
    }
  }

  static Future<Either<Failure, Unit>> updateDoctorProfile(
    DoctorModel doctor,
  ) async {
    try {
      if (doctor.image != null) {
        doctor.imageUrl = await uploadImageToCloudinary(doctor.image!) ?? '';
      }
      await FirebaseProvider.updateDoctor(doctor);
      return right(unit);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
