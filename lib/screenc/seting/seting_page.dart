import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/screenc/screenc.dart';
import 'package:moody/blocs/blocs.dart';

class SetingPage extends StatefulWidget {
  const SetingPage({super.key});

  @override
  State<SetingPage> createState() => _SetingPageState();
}

class _SetingPageState extends State<SetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 0),
              child: SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                    iconSize: 60,
                    icon: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFADAD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Color(0xFFFDFFB6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    }),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 0),
              child: SizedBox(
                width: 60,
                height: 60,
                child: IconButton(
                    iconSize: 60,
                    icon: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFADAD),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings,
                        size: 30,
                        color: Color(0xFFFDFFB6),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage(
                                  title: '',
                                )),
                      );
                    }),
              )),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Action when tapping outside the container
              },
              child: Container(
                color: Colors.transparent, // Background transparent
              ),
            ),
          ),
          Positioned(
            top: 30, // คำนวณตำแหน่งตามที่ต้องการ
            left: 30, // คำนวณตำแหน่งตามที่ต้องการ
            child: CustomPaint(
              painter: NotchPainter2(),
              child: Container(
                width: 360,
                height: 700,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/changee_password');
                      },
                      child: Text(
                          'Change Password                             > '),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow[100],
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutUserEvent());
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/welcome', (route) => false);
                      },
                      child: Text(
                          'Loguot                                                > '),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow[100],
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotchPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.lightBlue[100]!;
    Path path = Path();

    // วาดหางกล่องที่ชี้ไปยังไอคอนโปรไฟล์บน AppBar
    path.moveTo(size.width / 2 - -145, 0); // จุดเริ่มต้นหาง
    path.lineTo(size.width / 1.025, -25); // จุดปลายหาง (หางลงล่าง)
    path.lineTo(size.width / 1 + -0.11, 20); // จุดสิ้นสุดหาง

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
