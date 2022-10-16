import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/ok_button.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';
import 'package:temrinnotuygulamasiiki/screen/ogrenci_puan_listeleme_page_view.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';

class TemrinNotListelemePageView extends StatefulWidget {
  TemrinNotListelemePageView({Key? key}) : super(key: key);

  @override
  State<TemrinNotListelemePageView> createState() => _TemrinNotListelemePageViewState();
}

String _sinifSecText = "Sınıf Seç";
String _dersSecText = "Ders Seç";
String _ogrenciSecText = "Öğrenci Seç";

List<SinifModel> sinifList = [];
List<DersModel> dersList = [];
List<TemrinModel> temrinList = [];
List<OgrenciModel> ogrenciList = [];

int? _secilenSinifId;
String? _secilenSinifAd;
int? _secilenDersId;
String? _secilenDersAd;
int? _secilenTemrinId;
int? _secilenOgrenciId;
String? _secilenOgrenciAd;
OgrenciModel? _secilenOgrenciModel;

bool durum = false;

class _TemrinNotListelemePageViewState extends State<TemrinNotListelemePageView> {
  @override
  void initState() {
    super.initState();
    sinifListesiniGetir;
  }

  Future<void> get sinifListesiniGetir async {
    sinifList = await SinifDatabaseProvider().getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: customAppBar(
        context: context,
        title: const Text('Öğrenci Not Listeleme'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(visible: durum, child: _buildFloatingAcionButton(context)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sınıf:', style: TextStyle(fontSize: 18)),
            _buildSinifSec(context),
            const Text('Ders:', style: TextStyle(fontSize: 18)),
            _buildDersSec(context),
            const Text('Öğrenci:', style: TextStyle(fontSize: 18)),
            _buildOgrenciSec(context),
          ],
        ),
      ),
    );
  }

  Padding _buildFloatingAcionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton.extended(
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        label: Text('Notları Listele'),
        icon: const Icon(Icons.arrow_circle_right_outlined),
        onPressed: () {
          print('sinif id $_secilenSinifId, ders id: $_secilenDersId, temrin id: $_secilenTemrinId');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OgrenciPuanListPageView(
                  sinifId: _secilenSinifId ?? -1, dersId: _secilenDersId ?? -1, ogrenciModel: _secilenOgrenciModel ?? OgrenciModel())));
        },
      ),
    );
  }

  List<String> buildItems(List<SinifModel> sinifModel) {
    final items = sinifModel.map((e) => e.sinifAd.toString()).toList();
    return items;
  }

  _buildSinifSec(BuildContext context) {
    return myCustomMenuButton(
        context, (() => _showAlertSinifSectDialog(context)), Text(_secilenSinifAd ?? _sinifSecText), IconsConstans.sinifIcon, null);
  }

  _buildDersSec(BuildContext context) {
    return myCustomMenuButton(
        context, (() => _showAlertDersSecDialog(context, _secilenSinifId)), Text(_secilenDersAd ?? _dersSecText), IconsConstans.dersIcon, null);
  }

  _buildOgrenciSec(BuildContext context) {
    return myCustomMenuButton(context, (() => _showAlertOgrenciSecDialog(context, _secilenDersId)), Text(_secilenOgrenciAd ?? _ogrenciSecText),
        IconsConstans.temrinIcon, null);
  }

// Alert Dialog function
  _showAlertSinifSectDialog(context) {
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
                //secimleriSifirla;
              },
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        _secilenDersAd = null;
        //_secilenTemrinAd = null;
        durum = false;
        //print('_secilenDersAd : $_secilenDersAd');
      });
    });
  }

  _showAlertDersSecDialog(context, int? sinifId) async {
    // flutter defined function
    await dersListesiniGetir;
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
                  labelText: "Ders Seç",
                  //hintText: "country in menu mode",
                ),
              ),
              items: buildItemsDers(dersList),
              onChanged: (value) {
                int _dersid = dersList.singleWhere((element) => element.dersAd == value).id ?? -1;
                _secilenDersId = _dersid;
                print('dersid : $_secilenDersId');
                print('dersAd : $value');
                _secilenDersAd = value;
              },
            ),
          ),
        );
      },
    ).then((value) {
      setState(() {
        // _secilenTemrinAd = null;
        durum = false;
        //print('_secilenTemrinAd : $_secilenTemrinAd');
      });
    });
  }

  _showAlertOgrenciSecDialog(context, int? sinifId) async {
    // flutter defined function
    await ogrenciListesiniGetir;
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
                  prefixIcon: IconsConstans.temrinIcon,
                  labelText: "Ögrenci Seç",
                  //hintText: "country in menu mode",
                ),
              ),
              items: buildItemsOgrenci(ogrenciList),
              onChanged: (value) {
                print(value);
                //int _ogrenciId = ogrenciList.singleWhere((element) => element.ogrenciAdSoyad == value).id ?? -1;
                _secilenOgrenciModel = ogrenciList.singleWhere((element) => element.ogrenciAdSoyad == value);

                _secilenOgrenciId = _secilenOgrenciModel!.id ?? -1;
                print('_ogrenciId : $_secilenOgrenciId');
                print('_ogrenciad : $value');
                _secilenOgrenciAd = value;
              },
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          if (_secilenSinifId! > -1 && _secilenDersId! > -1 && (_secilenOgrenciId ?? -1) > -1) {
            durum = true;
          } else {
            durum = false;
          }
        });
      }
    });
  }

  void secimleriSifirla() {
    _secilenDersId = null;
    _secilenDersAd = null;
    // _secilenTemrinAd = null;
    _secilenTemrinId = null;
    _secilenOgrenciAd = null;
    _secilenOgrenciId = null;
  }

  void buildOkButtononPressed() {
    print('sinifId : $_secilenSinifId');
    Navigator.of(context).pop(SinifModel());
  }

  List<String> buildItemsDers(List<DersModel> dersModel) {
    final items = dersModel.map((e) => e.dersAd.toString()).toList();
    return items;
  }

  List<String> buildItemsTemrin(List<TemrinModel> temrinModel) {
    final items = temrinModel.map((e) => e.temrinKonusu.toString()).toList();
    return items;
  }

  List<String> buildItemsOgrenci(List<OgrenciModel> ogrenciModel) {
    final items = ogrenciModel.map((e) => e.ogrenciAdSoyad.toString().trim()).toList();
    return items;
  }

  Future<void> get dersListesiniGetir async {
    dersList = await DersDatabaseProvider().getFilterList(_secilenSinifId ?? 0);
  }

  Future<void> get temrinListesiniGetir async {
    temrinList = await TemrinDatabaseProvider().getFilterList(_secilenDersId ?? 0);
  }

  Future<void> get ogrenciListesiniGetir async {
    ogrenciList = await OgrenciDatabaseProvider().getFilterList(_secilenSinifId ?? 0);
  }
}
