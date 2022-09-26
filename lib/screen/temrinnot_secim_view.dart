import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/ok_button.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';

class TemrinNotSecimPageView extends StatefulWidget {
  const TemrinNotSecimPageView({Key? key}) : super(key: key);
  @override
  State<TemrinNotSecimPageView> createState() => _TemrinNotSecimPageViewState();
}

String _sinifSecText = "Sınıf Seç";
String _dersSecText = "Ders Seç";
String _temrinSecText = "Temrin Seç";

List<SinifModel> sinifList = [];
int? _secilenSinifId;
String? _secilenSinifAd;

int? _secilenDersId;
String? _secilenDersAd;

class _TemrinNotSecimPageViewState extends State<TemrinNotSecimPageView> {
  @override
  void initState() {
    super.initState();
    sinifListesiniGetir;
  }

  Future<void> get sinifListesiniGetir async {
    sinifList = await SinifDatabaseProvider().getList();
    SinifModel tumuModel = SinifModel(id: -1, sinifAd: "Tüm Sınıflar");
    sinifList.insert(0, tumuModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: customAppBar(
        context: context,
        title: const Text('Temrin Seçim'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sınıf:', style: TextStyle(fontSize: 18)),
            _buildSinifSec(context),
            const Text('Ders:', style: TextStyle(fontSize: 18)),
            //_buildDersSec(context),
            const Text('Temrin:', style: TextStyle(fontSize: 18)),
            //_buildTemrinSec(context),
          ],
        ),
      ),
    );
  }

  List<String> buildItems(List<SinifModel> sinifModel) {
    final items = sinifModel.map((e) => e.sinifAd.toString()).toList();
    return items;
  }

  _buildSinifSec(BuildContext context) {
    return myCustomMenuButton(context, (() => _showAlertDialog(context)), Text(_secilenSinifAd ?? _sinifSecText),
        IconsConstans.dersIcon, null);
    // return TextButton(
    //   child: Text(_secilenSinifAd ?? _sinifSecText),
    //   onPressed: (() => _showAlertDialog(context)),
    // );
    //_showAlertDialog;
  }

// Alert Dialog function
  _showAlertDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          //title: Center(child: Text("Sınıf Seç")),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCancelButton(context),
                const SizedBox(width: 10),
                buildOkButton(context, buildOkButtononPressed),
              ],
            ),
          ],
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            //height: MediaQuery.of(context).size.height * .4,
            child: DropdownSearch<String>(
              
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  prefixIcon: IconsConstans.dersIcon,
                  labelText: "Sınıf Seç",
                  //hintText: "country in menu mode",
                ),
              ),
              items: buildItems(sinifList),
              onChanged: (value) {
                int _sinifid = sinifList.singleWhere((element) => element.sinifAd == value).id ?? -1;
                _secilenSinifId = _sinifid;
                print('sinifId : $_secilenSinifId');
                print('sinifSinifAd : $value');
                _secilenSinifAd = value;

                setState(() {
                  secimleriSifirla;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void secimleriSifirla() {
    _secilenDersId = null;
    _secilenDersAd = null;
  }

  void buildOkButtononPressed() {
    print('sinifId : $_secilenSinifId');
    Navigator.of(context).pop(SinifModel());
  }
}
/*

AlertDialog(
        title: Center(child: Text("Ders Seç")),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCancelButton(context),
              const SizedBox(width: 10),
              buildOkButton(context, buildOkButtononPressed),
            ],
          ),
        ],
        content: SizedBox(
          width: MediaQuery.of(context).size.width * .6,
          child: DropdownSearch<String>(
            items: buildItems(sinifList),
            onChanged: (value) {
              int _sinifid = sinifList.singleWhere((element) => element.sinifAd == value).id ?? -1;
              sinifId = _sinifid;
              print('sinifId : $sinifId');
            },
          ),
        ),
      ),
 */
