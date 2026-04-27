import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/app/my_app.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPref.init();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase Initialization Error: \$e");
  }

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('ar'),
      child: MainApp(),
    ),
  );
}
