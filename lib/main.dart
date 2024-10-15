import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/blocs/blocs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:moody/screenc/screenc.dart';

import 'repositories/repository.dart'; // นำเข้า WelcomePage ของคุณ

void main() {
  final storage = const FlutterSecureStorage();
  final authRepository = AuthRepository();
  final moodRepository = MoodRepository();
  runApp(MyApp(
      storage: storage,
      authRepository: authRepository,
      moodRepository: moodRepository));
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;
  final MoodRepository moodRepository;

  const MyApp({
    super.key,
    required this.storage,
    required this.authRepository,
    required this.moodRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider<MoodBloc>(
          create: (context) => MoodBloc(moodRepository),
        ),
      ],
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
          '/home': (context) => const HomePage(
                title: '',
              ),
          '/profile': (context) => const ProfilePage(),
          '/changee_password': (context) => const ChangePasswordPage(),
        },
      ),
    );
  }
}
