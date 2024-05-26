import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/features/user_auth/presentation/pages/change_password.dart';
import 'package:real_estate_app/firebase_options.dart';
import 'package:real_estate_app/models/user.dart';
import 'package:real_estate_app/pages/add_announcement_page.dart';
import 'package:real_estate_app/pages/favorites_page.dart';
import 'package:real_estate_app/pages/profile_page.dart';
import 'package:real_estate_app/pages/root.dart';
import 'package:real_estate_app/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:real_estate_app/features/user_auth/presentation/pages/login_page.dart';
import 'package:real_estate_app/features/app/splash_screen/splash_screen.dart';
import 'package:real_estate_app/theme/color.dart';
import 'package:real_estate_app/pages/settings_page.dart';
import 'package:real_estate_app/pages/conversations_page.dart';
import 'package:real_estate_app/pages/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      theme: ThemeData(
        primaryColor: AppColor.primary,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      routes: {
        '/': (context) => const SplashScreen(
              child: LoginPage(),
            ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => RootApp(onToggleTheme: toggleTheme),
        '/settings': (context) => const SettingsPage(),
        '/conversations': (context) => const ConversationsPage(),
        '/chat': (context) => const ChatPage(name: '', image: ''),
        '/profile': (context) => const ProfilePage(),
        '/favorites_page': (context) => const FavoritesPage(),
        '/change_password': (context) => const ChangePasswordPage(),
        '/addAnnouncement': (context) => const AddAnnouncementPage(),
      },
    );
  }
}
