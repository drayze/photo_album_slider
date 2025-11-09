import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'picture_frame.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory settings = await getApplicationDocumentsDirectory();
  Hive.init(settings.path);
  await Hive.openBox('pictures');
  runApp(const MyPics());
}

class MyPics extends StatelessWidget {
  const MyPics({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Picture Frame',
      home: SlideShow(),
    );
  }
}
