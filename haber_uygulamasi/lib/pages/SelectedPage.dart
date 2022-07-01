// import 'package:flutter/material.dart';
// import 'package:haber_uygulamasi/category_utils/category.dart';
// import 'package:haber_uygulamasi/model/newsModel.dart';

// import '../services/api_services.dart';

// class SelectedPage extends StatelessWidget {
//   const SelectedPage({Key? key, required this.model}) : super(key: key);

//   final Category model;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hbaerler',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Material App Bar'),
//         ),
//         body: Center(
//             child: FutureBuilder(
//               future: ApiServices.getInstance().getNews(model.categoryName!),
//               builder: (context, snapshot) {
//                 if(snapshot.hasData && snapshot.data != null){
//                   return 
//                 }
//               }
//             ),),
//       ),
//     );
//   }

//   GridView _buildGridView(String image) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 20,
//         crossAxisSpacing: 20,
//         childAspectRatio: 0.80,
//       ),
//       itemCount: _articleList.length,
//       itemBuilder: (BuildContext context, int index) {
//       /*   ApiServices.getInstance()
//             .getNews(_categoryList[index].categoryName ??''); */
//         // debugPrint(articlelist[index].urlToImage.toString() + "&&&&&&&&&&&&&&&&&&&&&&&&&");
//         if (isLoading) {
//           return buildEffect();
//         } else {
//           var imageUrl = _articleList[index].urlToImage ?? image;
//           var text = _articleList[index].title!;

//           if (imageUrl.contains('asset')) {
//             imageUrl =
//                 "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";
//           }

//           return InkWell(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => News(model: _articleList[index])));
//             },
//             child: Container(
//               color: Colors.white,
//               // padding: const EdgeInsets.symmetric(vertical: 32),
//               child: Column(
//                 children: [
//                   Hero(
//                       tag: 'news $index',
//                       child: Image.network(
//                         imageUrl,
//                         width: double.infinity,
//                       ) /* Image.network(image , width: double.infinity,) */),
//                   Expanded(
//                     child: Text(
//                       text,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w600,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 4,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

// }















// /* import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:haber_uygulamasi/category_utils/category.dart';
// import 'package:haber_uygulamasi/model/newsModel.dart';
// import 'package:haber_uygulamasi/services/api_services.dart';
// import 'package:shimmer/shimmer.dart';

// import '../news/news.dart';

// void main() => runApp(SelectedPage());

// class SelectedPage extends StatefulWidget {
//   SelectedPage({Key? key}) : super(key: key);

//   @override
//   State<SelectedPage> createState() => _SelectedPageState();
// }

// class _SelectedPageState extends State<SelectedPage> {
//   final List<Category> _categoryList = Utils.getCategory();
//   List<Article> _articleList = [];
//   String image =
//       "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";
//   bool isLoading = false;

//   getEffect() async {
//     setState(() {
//       isLoading = true;
//     });
//     await Future.delayed(const Duration(seconds: 9), () {});
//     setState(() {
//       isLoading = false;
//     });
//   }

//   buildEffect() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey.shade300,
//       highlightColor: Colors.grey.shade100,
//       child: Container(
//         color: Colors.grey,
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     getEffect();
//     isLoading = false;
//     ApiServices.getInstance().getNews('science').then((value) {
//       setState(() {
//         _articleList = value!;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Material App',
//         home: Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               centerTitle: true,
//               title: const Text(
//                 'Haberler',
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                     fontFamily: 'Staatliches'),
//               ),
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _buildSlider(image),
//                     _buildGridView(image),
//                   ],
//                 ),
//               ),
//             )));
//   }

//   GridView _buildGridView(String image) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 20,
//         crossAxisSpacing: 20,
//         childAspectRatio: 0.80,
//       ),
//       itemCount: _articleList.length,
//       itemBuilder: (BuildContext context, int index) {
//       /*   ApiServices.getInstance()
//             .getNews(_categoryList[index].categoryName ??''); */
//         // debugPrint(articlelist[index].urlToImage.toString() + "&&&&&&&&&&&&&&&&&&&&&&&&&");
//         if (isLoading) {
//           return buildEffect();
//         } else {
//           var imageUrl = _articleList[index].urlToImage ?? image;
//           var text = _articleList[index].title!;

//           if (imageUrl.contains('asset')) {
//             imageUrl =
//                 "https://www.huaweiailesi.com/wp-content/uploads/2021/07/share.png";
//           }

//           return InkWell(
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => News(model: _articleList[index])));
//             },
//             child: Container(
//               color: Colors.white,
//               // padding: const EdgeInsets.symmetric(vertical: 32),
//               child: Column(
//                 children: [
//                   Hero(
//                       tag: 'news $index',
//                       child: Image.network(
//                         imageUrl,
//                         width: double.infinity,
//                       ) /* Image.network(image , width: double.infinity,) */),
//                   Expanded(
//                     child: Text(
//                       text,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w600,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 4,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }

//   Container _buildSlider(String image) {
//     return Container(
//         margin: const EdgeInsets.only(bottom: 32),
//         height: 200,
//         width: double.infinity,
//         child: CarouselSlider(
//           options: CarouselOptions(
//               viewportFraction: 1,
//               enlargeCenterPage: true,
//               enableInfiniteScroll: false,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 2)),
//           items: _articleList
//               .map(
//                 (e) => Container(
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(25)),
//                   width: double.infinity,
//                   height: 200,
//                   child: Hero(
//                     tag: e.urlToImage ?? image,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => News(model: e)));
//                       },
//                       child: Image.network(
//                         e.urlToImage ?? image,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//         ));
//   }
// }
//  */