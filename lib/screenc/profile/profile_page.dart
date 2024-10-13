import 'package:flutter/material.dart';
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
        backgroundColor: Colors.lightBlue[100],
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            key: profileIconKey, // ตั้ง Key ให้กับไอคอนโปรไฟล์
            icon: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Icon(
                Icons.settings,
                color: Colors.yellow[200],
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SetingPage()),
              );
            },
          ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.yellow[100],
                      backgroundImage: AssetImage(
                        'assets/images/avatar_02.jpg', // ภาพแทนสำหรับ avatar
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft, // ชิดซ้าย
                      child: Text('Email'),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      initialValue: 'email@example.com',
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft, // ชิดซ้าย
                      child: Text('Gender'),
                    ),
                    SizedBox(height: 8),
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
                ),
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
    path.moveTo(size.width / 2 - -100, 0); // จุดเริ่มต้นหาง
    path.lineTo(size.width / 1.2, -20); // จุดปลายหาง (หางลงล่าง)
    path.lineTo(size.width / 1 + -40, 0); // จุดสิ้นสุดหาง

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
