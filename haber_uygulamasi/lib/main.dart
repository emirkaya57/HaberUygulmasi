// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:haber_uygulamasi/pages/home_page.dart';
import 'package:haber_uygulamasi/viewmodels/news_viewmodel.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final style = const TextStyle(
      fontSize: 13, fontFamily: 'Roboto', fontWeight: FontWeight.w600);
 

  @override
  Widget build(BuildContext context) {
    return
    ChangeNotifierProvider(
      create: (context) => NewsViewModel() ,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Haber Uygulaması',
        home:  HomePage()),
    );
  }


 }
