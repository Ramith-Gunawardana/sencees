import 'package:flutter/material.dart';
import 'package:sencees/core/configs/themes.dart';
import 'package:sencees/features/authentication/presentation/views/login_view.dart';
import 'package:sencees/features/user_onboard/presentation/views/onboarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;

  runApp(MyApp(onboarding: onboarding));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sencees',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: onboarding ? const LoginView() : const OnboardingView(),
    );
  }
}
