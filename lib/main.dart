import 'package:flutter/material.dart';

import 'screens/home.dart';
// import 'screens/add_mood.dart';
// import 'screens/about_mood.dart';
// import 'screens/recommend_activity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(title: '',),
    );
  }
}
