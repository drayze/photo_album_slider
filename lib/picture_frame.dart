import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SlideShow extends StatefulWidget {
  const SlideShow({Key? key}) : super(key: key);

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    getImages();
  }

  Future<void> getImages() async {
    final directory = await rootBundle.loadString('photos/');
    final Map<String, dynamic> manifestMap = jsonDecode(directory);

    final photos = manifestMap.keys
      .where((String key) => key.startsWith('photos/')).toList();


    setState(() {
      items = photos;
    });
    }

  @override
  Widget build(BuildContext context) {
    if(items.isEmpty) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Memories with you.'),
          ), body: Center(child: CircularProgressIndicator()),);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memories with you.'),
      ),
      body: Center(
        child: CarouselSlider(options: CarouselOptions(
          height: 400,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          aspectRatio: 16/9,
        ),
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.asset(item, fit: BoxFit.cover),
              );
            },
          );
        }).toList(),
        ),)
      );
  }
}
