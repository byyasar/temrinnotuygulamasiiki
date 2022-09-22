import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);
  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context:context, title:const Text('Temrin Not Uygulaması')),
      drawer: buildDrawer(context),
      backgroundColor: Colors.transparent,
      body: const Center(child: Text('Temrin Not Uygulaması')),
    );
  }
}
