import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:moody/screenc/screenc.dart';

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
        backgroundColor: Colors.lightBlue[100],
        title: Text(
          'Seting',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Icon(
                Icons.person,
                color: Colors.yellow[200],
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Icon(
                Icons.settings,
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
        ],
      ),
    );
  }
}
