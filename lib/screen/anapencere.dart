import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/database_helper.dart';
import 'package:temrinnotuygulamasiiki/models/ogrenci_model.dart';

class AnapencereView extends StatefulWidget {
  const AnapencereView({Key? key}) : super(key: key);

  @override
  State<AnapencereView> createState() => _AnapencereViewState();
}

class _AnapencereViewState extends State<AnapencereView> {
  List<dynamic> ogrenciList = [];

  @override
  void initState() {
    super.initState();
    verileriGetir();
  }

  verileriGetir() async {
    var databaseHelper = DatabaseHelper();
    ogrenciList = await databaseHelper.ogrenciListesiGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      child: ListView.builder(
        itemCount: ogrenciList.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(ogrenciList[index]['ogrenciAdSoyad'].toString());
        },
      ),
    );
  }
}
