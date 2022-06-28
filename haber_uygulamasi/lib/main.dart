// ignore_for_file: library_prefixes

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:haber_uygulamasi/news/carousel.dart';
import 'package:haber_uygulamasi/news/news.dart';
import 'package:haber_uygulamasi/services/api_services.dart';
import 'package:haber_uygulamasi/model/newsModel.dart' as newsModel;
import 'package:shimmer/shimmer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final style = const TextStyle(
      fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.w600);
  List<newsModel.Article> articlelist = [];
  bool isLoading = false;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
    isLoading = true;
    getEffect();
    ApiServices.getNews().then((value) {
      setState(() {
        articlelist = value!;
      });
    });
    super.initState();
  }

  getEffect() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 9), () {});
    setState(() {
      isLoading = false;
    });
  }

  buildEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image =
        "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Haber Uygulaması',
      home: Scaffold(
        appBar: AppBar(
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 8, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(28)),
                  child: const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                    size: 25,
                  )),
            ],
            centerTitle: true,
            title: const Text(
              'Haberler',
              style: TextStyle(
                  color: Colors.black, fontSize: 25, fontFamily: 'Staatliches'),
            ),
            backgroundColor: Colors.white),
        body: news(image),
      ),
    );
  }

  Widget news(String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 32),
                height: 200,
                width: double.infinity,
                child: CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2)),
                  items: articlelist
                      .map((e) => InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => News(model: e)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              width: double.infinity,
                              height: 200,
                              child: Hero(
                                tag: e,
                                child: Image.network(
                                  e.urlToImage ?? image,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                )),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.80,
              ),
              itemCount: articlelist.length,
              itemBuilder: (BuildContext context, int index) {
                // debugPrint(articlelist[index].urlToImage.toString() + "&&&&&&&&&&&&&&&&&&&&&&&&&");
                if (isLoading) {
                  return buildEffect();
                } else {
                  var imageUrl = articlelist[index].urlToImage ?? image;
                  var text = articlelist[index].title!;

                  if (imageUrl.contains('asset')) {
                    imageUrl =
                        "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";
                  }

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              News(model: articlelist[index])));
                    },
                    child: Container(
                      color: Colors.white,
                      // padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          Hero(
                              tag: 'news $index',
                              child: Image.network(
                                imageUrl,
                                width: double.infinity,
                              ) /* Image.network(image , width: double.infinity,) */),
                          Expanded(
                            child: Text(
                              text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
