import 'package:flutter/material.dart';
import 'picture_frame.dart';

void main() {
  runApp(const MyPics());
}

class MyPics extends StatelessWidget {
  const MyPics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Frame',
      home: SlideShow(),
    );
  }
}
