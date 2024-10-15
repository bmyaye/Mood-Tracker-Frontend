import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moody/blocs/blocs.dart';
import 'package:moody/screenc/screenc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GlobalKey profileIconKey = GlobalKey(); // ใช้ Key เพื่อคำนวณตำแหน่ง

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text(
        //   'Profile',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
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
                            builder: (context) => const HomePage(
                                  title: '',
                                )),
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
                            builder: (context) => const SetingPage()),
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
              painter: NotchPainter(),
              child: Container(
                width: 360,
                height: 700,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.yellow[100],
                        backgroundImage: const AssetImage(
                          'assets/images/avatar_02.jpg', // ภาพแทนสำหรับ avatar
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        state.user?.username ?? 'Unknown Username',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft, // ชิดซ้าย
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        initialValue: state.user?.email ?? 'Unknown Email',
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.yellow[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft, // ชิดซ้าย
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: 'Male',
                        items: ['Male', 'Female', 'Other']
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (String? newValue) {
                          // Handle change here
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.yellow[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.lightBlue[100]!;
    Path path = Path();

    // วาดหางกล่องที่ชี้ไปยังไอคอนโปรไฟล์บน AppBar
    path.moveTo(size.width / 2 - -99, 0); // จุดเริ่มต้นหาง
    path.lineTo(size.width / 1.22, -25); // จุดปลายหาง (หางลงล่าง)
    path.lineTo(size.width / 1 + -41, 0); // จุดสิ้นสุดหาง

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
