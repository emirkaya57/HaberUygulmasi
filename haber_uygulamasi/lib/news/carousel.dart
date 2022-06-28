// ignore_for_file: library_prefixes

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:haber_uygulamasi/model/newsModel.dart' as newsModel;

class SliderPage extends StatefulWidget {
  const SliderPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final List<newsModel.Article> _list = [];
  late PageController _pageController;
  int _currentPage = 0;
  String image =
      "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
