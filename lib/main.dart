import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/screen/anapencere.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      home: const AnapencereView(),
    );
  }
}
