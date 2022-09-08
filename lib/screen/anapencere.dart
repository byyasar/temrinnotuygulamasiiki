import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';

class AnapencereView extends StatefulWidget {
  const AnapencereView({Key? key}) : super(key: key);

  @override
  State<AnapencereView> createState() => _AnapencereViewState();
}

class _AnapencereViewState extends State<AnapencereView> {
  @override
  Widget build(BuildContext context) {
    var databaseHelper = DatabaseHelper();
    databaseHelper.ogrencileriGetir();

    return Container(
      color: Colors.amber,
    );
  }
}
