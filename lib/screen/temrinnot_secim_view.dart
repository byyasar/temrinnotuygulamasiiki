import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';

class TemrinNotSecimPageView extends StatefulWidget {
  const TemrinNotSecimPageView({Key? key}) : super(key: key);
  @override
  State<TemrinNotSecimPageView> createState() => _TemrinNotSecimPageViewState();
}

class _TemrinNotSecimPageViewState extends State<TemrinNotSecimPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: customAppBar(
        context: context,
        title: const Text('Temrin Seçim'),
      ),
    );
  }
}
