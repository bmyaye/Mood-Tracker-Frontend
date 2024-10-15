import 'package:flutter/material.dart';

class RecommendActivityPage extends StatefulWidget {
  const RecommendActivityPage({super.key, required this.title});

  final String title;

  @override
  State<RecommendActivityPage> createState() => _RecommendActivityPageState();
}

class _RecommendActivityPageState extends State<RecommendActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: IconButton(
                onPressed: () {
                  // Add your action here
                  print("Profile Button was clicked");
                },
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
                iconSize: 60,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: IconButton(
                onPressed: () {
                  // Add your action here
                  print("Settings Button was clicked");
                },
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
                iconSize: 60,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 15),
              Container(
                width: 360,
                height: 595,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9EDF8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),

          // Bottom background
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFD9EDF8),
                borderRadius:
                    BorderRadius.vertical(top: Radius.elliptical(200, 100)),
              ),
            ),
          ),

          // Add button background
          Positioned(
            left: 0,
            bottom: 37,
            right: 0,
            child: Container(
              width: 125,
              height: 125,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Add button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                print("onClick add button");
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFDFFB6),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 70,
                    color: Color(0xFFFFD6A5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}