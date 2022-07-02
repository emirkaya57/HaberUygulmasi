import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber_uygulamasi/category_utils/category.dart';
import 'package:haber_uygulamasi/services/api_services.dart';
import 'package:shimmer/shimmer.dart';

import '../model/newsModel.dart';
import '../news/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> _categoryList = Utils.getCategory();
  List<Article> articlelist = [];
  // late final List<PopupMenuEntry> _menuList;
  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    getEffect();

    /*  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NewsViewModel>(context, listen: false)
          .fetchNews(_categoryList[2].toString());
    }); */

    ApiServices.getInstance()
        .getNews(_categoryList[0].categoryName.toString())
        .then((value) {
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
  Widget build(BuildContext context) {
    String image =
        "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";
    return Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            // actions: [PopupMenuButton(itemBuilder: (context) => _menuList)],
            centerTitle: true,
            title: const Text(
              'Haberler',
              style: TextStyle(
                  color: Colors.black, fontSize: 25, fontFamily: 'Staatliches'),
            ),
            backgroundColor: Colors.white),
        body: news(
            image) /* FutureBuilder(
        future: Provider.of<NewsViewModel>(context).listenNewsList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData &&
              snapshot.data != null) {
            return news(image);
          } else if (snapshot.hasError && snapshot.error != null) {
            return const Text('Hata');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ), */
        );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            for (int i = 0; i < _categoryList.length; i++) {
              return ListTile(
                  title: Text(_categoryList[index].categoryName.toString()),
                  onTap: () {
                    ApiServices.getInstance()
                        .getNews(_categoryList[index].categoryName.toString())
                        .then((value) {
                      setState(() {
                        articlelist = value!;
                        Navigator.pop(context);
                      });
                    });
                  });
            }
            return const CircularProgressIndicator();
          }),
    );
  }

  Widget news(String image) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSlider(image),
            _buildGridView(image),
          ],
        ),
      ),
    );
  }

  MasonryGridView _buildGridView(String image) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
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
                  builder: (context) => News(model: articlelist[index])));
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ]),
                margin: const EdgeInsets.all(4),
                height: text.length.toDouble() * 3.2,

                // padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Hero(
                      tag: 'news $index',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          fit: BoxFit.fill,
                          imageUrl,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          text,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Bitter',
                            fontWeight: FontWeight.w400,
                          ),
                          //overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Container _buildSlider(String image) {
    return Container(
        margin: const EdgeInsets.only(bottom: 32),
        height: 200,
        width: double.infinity,
        child: Container(
          child: CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2)),
            items: articlelist
                .map(
                  (e) => Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ]),
                    width: double.infinity,
                    height: 200,
                    child: Hero(
                      tag: e.urlToImage ?? image,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => News(model: e)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            fit: BoxFit.fill,
                            e.urlToImage ?? image,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ));
  }
}
