import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<SlideShow> createState() => _SlideShowState();
}


class _SlideShowState extends State<SlideShow> {
  List<String> items = [];
  Duration _autoPlaySpeed = const Duration(seconds: 0);
  bool _autoPlay = false;

  @override
  void initState() {
    super.initState();
    getImages();
  }
  void getImages() async {
    ImagePicker imagePicker = ImagePicker();
    List<String> photos = [];
    imagePicker.pickImage(source: ImageSource.gallery);


    setState(() {
      items = photos;
    });
  }

  void _settingsMenu() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Settings'),
        content: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Scroll Speed',
                  style: TextStyle(fontWeight: FontWeight.bold),),
                ListTile(
                  leading: const Icon(Icons.speed_outlined),
                  title: const Text('3 seconds'),
                  onTap: () {
                    setState(() {
                        _autoPlaySpeed = const Duration(seconds: 3);
                        _autoPlay = true;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.speed_outlined),
                  title: const Text('5 seconds'),
                  onTap: () {
                    setState(() {
                      _autoPlaySpeed = const Duration(seconds: 5);
                      _autoPlay = true;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.speed_outlined),
                    title: const Text('8 seconds'),
                    onTap: () {
                      setState(() {
                        _autoPlaySpeed = const Duration(seconds: 8);
                        _autoPlay = true;
                      });
                      Navigator.pop(context);
                    }
                ), ListTile(
                  leading: const Icon(Icons.speed_outlined),
                  title: const Text('10 seconds'),
                  onTap: () {
                    setState(() {
                       _autoPlaySpeed = const Duration(seconds: 10);
                       _autoPlay = true;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.stop),
                  title: const Text('Stop'),
                  onTap: () {
                    setState(() {
                      _autoPlay = false;
                    });
                    Navigator.pop(context);
                  },
                )
              ]),
        ),);
    });
  }

    @override
    Widget build(BuildContext context) {
      if (items.isEmpty) {
        return Scaffold(
          appBar: AppBar(title: const Text('Memories with you.')),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Memories with you.'),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _settingsMenu();
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery
                  .of(context)
                  .size
                  .height - kToolbarHeight,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              autoPlay: _autoPlay,
              autoPlayInterval: _autoPlaySpeed,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              aspectRatio: 16 / 9,
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
                    child: Image.asset(item, fit: BoxFit.contain),
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    }
}