// ignore_for_file: avoid_print

import 'dart:async';

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/utils/notification/notification_service.dart';
import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:employee_application/app_router.dart';
import 'package:employee_application/firebase_options.dart';
import 'package:employee_application/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppBootstrap());
}

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeCore();
  }

  Future<void> _initializeCore() async {
    await Future.wait([
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      SharedPreferencesUtils().init(),
    ]);
    await configureDependencies();
    unawaited(NotificationService.initialize());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const _SplashApp();
        }
        if (snapshot.hasError) {
          return _SplashApp(error: snapshot.error.toString());
        }
        return const MyApp();
      },
    );
  }
}

class _SplashApp extends StatefulWidget {
  const _SplashApp({this.error});

  final String? error;

  @override
  State<_SplashApp> createState() => _SplashAppState();
}

class _SplashAppState extends State<_SplashApp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
    if (widget.error == null) {
      _controller.repeat(reverse: true, min: 0.9, max: 1.0);
    }
  }

  @override
  void didUpdateWidget(covariant _SplashApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error != null) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: ColorConstant.deepGreen,
        body: Center(
          child: widget.error == null
              ? AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value.clamp(0.0, 1.0),
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 160,
                    height: 160,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'صار خطأ بتحميل التطبيق:\n${widget.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
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
