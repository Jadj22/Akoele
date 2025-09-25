import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/password_forget_screen.dart';
import 'screens/form_screen.dart';
import 'screens/home_screen.dart';
import 'screens/qr_generator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const bool isLoggedIn = false; // TODO: brancher la logique métier plus tard
    return MaterialApp(
      title: 'Akoele',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false, // Masquer la bannière DEBUG
      // Use named routes for clearer navigation and to avoid dead code warnings
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/password_forget': (_) => const PasswordForgetScreen(),
        '/home': (_) => const HomeScreen(),
        '/qr_generate': (_) => const QrGeneratorScreen(),
        '/form': (ctx) {
          final arg = ModalRoute.of(ctx)?.settings.arguments as String?;
          return FormScreen(scannedValue: arg);
      },
      },
    );
  }
}

