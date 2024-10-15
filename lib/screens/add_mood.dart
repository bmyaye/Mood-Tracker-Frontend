import 'package:flutter/material.dart';

import 'about_mood.dart';

class AddMoodPage extends StatefulWidget {
  const AddMoodPage({
    Key? key,
    required this.title,
    this.moodEmoji = '',
    required this.selectedDate,
  }) : super(key: key);

  final String title;
  final String moodEmoji;
  final DateTime selectedDate;

  @override
  State<AddMoodPage> createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  String? selectedMood;

  void _onMoodSelected(String mood) {
    setState(() {
      selectedMood = mood;
    });
  }

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
          // Background
          Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'How about your day ?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  height: 0,
                  fontFamily: 'Itim',
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 360,
                height: 500,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD9EDF8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 55,
            left: 235,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(3.14),
              child: Container(
                width: 60,
                height: 100,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD9EDF8),
                  shape: StarBorder.polygon(
                    sides: 3,
                    pointRounding: 0.3,
                  ),
                ),
              ),
            ),
          ),

          // Bottom background
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFD9EDF8),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(200, 100),
                ),
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
                child: const Center(
                  child: Icon(
                    Icons.question_mark_rounded,
                    size: 70,
                    color: Color(0xFFFFD6A5),
                  ),
                ),
              ),
            ),
          ),

          // Mood Options
          Positioned(
            top: 180,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutMoodPage(
                                title: '',
                                mood: 'Great',
                                moodEmoji: 'assets/images/Great.png',
                                selectedMood: selectedMood,
                              ),
                            ),
                          ).then((returnedMood) {
                            if (returnedMood != null) {
                              Navigator.pop(context, returnedMood);
                            }
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/images/Great.png',
                                width: 100, height: 100),
                            const Text(
                              'Great',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Itim',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutMoodPage(
                                title: '',
                                mood: 'Good',
                                moodEmoji: 'assets/images/Good.png',
                                selectedMood: selectedMood,
                              ),
                            ),
                          ).then((returnedMood) {
                            if (returnedMood != null) {
                              Navigator.pop(context, returnedMood);
                            }
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/images/Good.png',
                                width: 100, height: 100),
                            const Text(
                              'Good',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Itim',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AboutMoodPage(
                                    title: '',
                                    mood: 'OK',
                                    moodEmoji: 'assets/images/OK.png',
                                    selectedMood: selectedMood,
                                  ),
                                ),
                              ).then((returnedMood) {
                                if (returnedMood != null) {
                                  Navigator.pop(context, returnedMood);
                                }
                              });
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: Column(
                              children: [
                                Image.asset('assets/images/OK.png',
                                    width: 100, height: 100),
                                const Text(
                                  'OK',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Itim',
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutMoodPage(
                                title: '',
                                mood: 'Not Good',
                                moodEmoji: 'assets/images/NotGood.png',
                                selectedMood: selectedMood,
                              ),
                            ),
                          ).then((returnedMood) {
                            if (returnedMood != null) {
                              Navigator.pop(context, returnedMood);
                            }
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/images/NotGood.png',
                                width: 100, height: 100),
                            const Text(
                              'Not Good',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Itim',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutMoodPage(
                                title: '',
                                mood: 'Bad',
                                moodEmoji: 'assets/images/Bad.png',
                                selectedMood: selectedMood,
                              ),
                            ),
                          ).then((returnedMood) {
                            if (returnedMood != null) {
                              Navigator.pop(context, returnedMood);
                            }
                          });
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/images/Bad.png',
                                width: 100, height: 100),
                            const Text(
                              'Bad',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Itim',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildMoodOption(
      BuildContext context, String emoji, String label, Color circleColor) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Handle the mood selection
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              // color: circleColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                emoji,
                style: const TextStyle(
                  fontSize: 60, // Icon size
                  fontFamily: 'Itim',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Itim',
          ),
        ),
      ],
    );
  }
}
