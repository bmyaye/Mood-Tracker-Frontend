import 'package:flutter/material.dart';

// import 'home.dart';

class AboutMoodPage extends StatefulWidget {
  const AboutMoodPage({
    Key? key,
    required this.title,
    required this.mood,
    required this.moodEmoji,
    required this.selectedMood, // Make sure to accept the mood emoji
  }) : super(key: key);

  final String title;
  final String mood;
  final String moodEmoji;
  final String? selectedMood;

  @override
  State<AboutMoodPage> createState() => _AboutMoodPageState();
}

class _AboutMoodPageState extends State<AboutMoodPage> {
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
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        widget.moodEmoji,
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 50,
            child: Center(
              child: Column(
                children: [
                  Text(widget.mood,
                      style: const TextStyle(
                        fontSize: 70,
                        color: Color(0xFF000000),
                        fontFamily: 'Itim',
                      )),
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      Container(
                        width: 320,
                        height: 320,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFDFFB6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 520,
            left: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 120,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFADAD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Itim',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Done Button
          Positioned(
            top: 520,
            right: 50,
            child: TextButton(
              // onPressed: () {
              //   Navigator.pop(context, widget.moodEmoji);
              //   print("mood: ${widget.moodEmoji}");
              // },
              onPressed: () {
                          Navigator.pop(
                              context, widget.mood); // Return the selected mood
                        },
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(
                    Colors.transparent), // Remove button press overlay effect
                padding: MaterialStateProperty.all(
                    EdgeInsets.zero), // Remove default padding
              ),
              child: Container(
                width: 120,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFD6A5), // Custom background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Itim',
                    ),
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
