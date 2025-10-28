import 'package:flutter/material.dart';

void main() {
  runApp(const MyPics());
}

class MyPics extends StatefulWidget {
  const MyPics({super.key});

  @override
  State<MyPics> createState() => _MyPicsState();
}

class _MyPicsState extends State<MyPics> {
  // Creating a PageController to control the scrolling of the photos
  late final PageController _pageController;
  int _currentPage = 0; // To keep track of the current page

  // Some placeholders for the photos
  final List<Color> _photoPlaceholders = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.indigo,
  ];

  @override
  void initState() {
    super.initState();
    // Initializing the PageController
    _pageController = PageController(initialPage: _currentPage);

    // Adding a listener to the PageController to update the current page
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    // Dispose the PageController to avoid memory leaks
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Photo Album Slider'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Center(
          // Controlling the size of the photo slider
          child: SizedBox(
            height: 300, // Height of the slider area
            child: PageView.builder(
              controller: _pageController,
              itemCount: _photoPlaceholders.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: _photoPlaceholders[index],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
