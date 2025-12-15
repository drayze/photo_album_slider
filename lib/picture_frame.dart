import 'dart:io';
import 'package:hive/hive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<SlideShow> createState() => _SlideShowState();
}


class _SlideShowState extends State<SlideShow> {
  List<String> items = [];
  Duration _autoPlaySpeed = const Duration(seconds: 0);
  bool _autoPlay = false;
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() async {
    final List<dynamic>? photos = Hive.box('pictures').get('photos');
    if (photos != null && photos.isNotEmpty) {
      setState(() {
        items = photos.cast<String>().toList();
      });
    }
  }
  void _pickImages() async {
    final List<AssetEntity>? pickedFiles = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 1000,));

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final List<String> newPaths = [];
      for (final asset in pickedFiles) {
        final file = await asset.file;
        if (file != null) {
          newPaths.add(file.path);
        }
      }
      final List<String> updatedPhotos = List.from(items)..addAll(newPaths);
      Hive.box('pictures').put('photos', updatedPhotos);
      setState(() {
        items = updatedPhotos;
      });
    }
  }

  void _removeCurrentImage() {
    if (items.isNotEmpty) {
      final List<String> updatedPhotos = List.from(items);
      updatedPhotos.removeAt(_currentIndex);
      Hive.box('pictures').put('photos', updatedPhotos);
      setState(() {
        items = updatedPhotos;
        if (_currentIndex >= items.length && items.isNotEmpty) {
          _currentIndex = items.length - 1;
        }
      });
    }
  }

  void _settingsMenu() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Settings'),
        content: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: const Icon(Icons.image_outlined),
                  title: const Text('Pick Images'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImages();
                  },
                ),
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
          body: Center(
              child: OutlinedButton(
                onPressed: () {
                  _pickImages();
                },
                child: const Text('Pick Images'),)),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Memories with you.'),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _removeCurrentImage,
                ),
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
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
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
                    child: Image.file(File(item), fit: BoxFit.contain),
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    }
}