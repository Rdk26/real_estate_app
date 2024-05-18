import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/firebase_options.dart';
// import 'package:real_estate_app/pages/login.dart';
// import 'package:real_estate_app/pages/register.dart';
import 'pages/root.dart';
import 'package:real_estate_app/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:real_estate_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:real_estate_app/features/app/splash_screen/splash_screen.dart';
import 'theme/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Real Estate App',
        theme: ThemeData(
          primaryColor: AppColor.primary,
        ),
        routes: {
          '/': (context) => const SplashScreen(
                // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
                child: LoginPage(),
              ),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignUpPage(),
          '/home': (context) => const RootApp(),
        });
  }
}
