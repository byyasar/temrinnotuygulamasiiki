import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/theme/light_theme.dart';
import 'package:temrinnotuygulamasiiki/screen/ders_page_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: LighTheme().theme,
      home: const DersPageView(),
    );
  }
}
