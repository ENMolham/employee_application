// ignore_for_file: avoid_print

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/utils/notification/notification_service.dart';
import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:employee_application/app_router.dart';
import 'package:employee_application/firebase_options.dart';
import 'package:employee_application/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  await SharedPreferencesUtils().init();
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstant.deepGreen,
          primary: ColorConstant.deepGreen,
        ),
        primaryColor: ColorConstant.deepGreen,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorConstant.deepGreen,
          // ignore: deprecated_member_use
          selectionColor: ColorConstant.deepGreen.withOpacity(0.3),
          selectionHandleColor: ColorConstant.deepGreen,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstant.deepGreen,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.deepGreen,
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.deepGreen, width: 2),
          ),
        ),
        fontFamily: 'Cairo',
      ),
    );
  }
}
