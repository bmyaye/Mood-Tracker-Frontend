import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/blocs/signup_bloc/auth_app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moody/screenc/screenc.dart';

import 'repositories/auth_repository.dart'; // นำเข้า WelcomePage ของคุณ

void main() {
  final storage = const FlutterSecureStorage();
  final authRepository = AuthRepository();
  runApp(MyApp(storage: storage, authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;

  const MyApp({
    super.key,
    required this.storage,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(authRepository),
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme.light(
                background: Colors.white,
                onBackground: Colors.black,
                primary: Color.fromRGBO(222, 218, 244, 1),
                onPrimary: Colors.black,
                secondary: Color.fromRGBO(217, 237, 248, 1),
                onSecondary: Colors.white,
                tertiary: Color.fromRGBO(253, 255, 182, 1),
                error: Colors.red,
                outline: Color(0xFF424242))),
        home: const WelcomePage(), // ตั้งค่าหน้าต้นฉบับเป็น WelcomePage
        routes: {
          '/welcome': (context) => const WelcomePage(),
          '/signin': (context) => const SignInPage(), // กำหนดเส้นทางที่นี่
          '/signup': (context) => const SignUpPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/changee_password': (context) => const ChangePasswordPage(),
        },
      ),
    );
  }
}
