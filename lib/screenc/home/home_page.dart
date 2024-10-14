import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:moody/screenc/screenc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                            builder: (context) => const SetingPage()),
                      );
                    }),
              )),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                onPressed: () {
                  // Action for FAB
                },
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.orange[200],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
