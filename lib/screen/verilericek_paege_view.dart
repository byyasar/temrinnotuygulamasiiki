import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/app_constants.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_dialog_func.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:kartal/kartal.dart';

class VerilericekPageView extends StatefulWidget {
  VerilericekPageView({Key? key}) : super(key: key);

  @override
  State<VerilericekPageView> createState() => _VerilericekPageViewState();
}

class _VerilericekPageViewState extends State<VerilericekPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            drawer: buildDrawer(context),
            appBar: customAppBar(context: context, title: Text('Db İşlemleri')),
            body: Column(
              children: [
                SizedBox(height: context.dynamicHeight(.1)),
                const Center(child: Text('Uzak sunucudan data çek')),
                myCustomMenuButton(context, () {
                  verileriGetir('sinif');
                }, const Text('Sınıfları Getir'), IconsConstans.sinifIcon, null),
                myCustomMenuButton(context, () {
                  verileriGetir('dersler');
                }, const Text('Dersleri Getir'), IconsConstans.dersIcon, null),
                myCustomMenuButton(context, () {
                  verileriGetir('temrinler');
                }, const Text('Temrinleri Getir'), IconsConstans.temrinIcon, null),
                myCustomMenuButton(context, () {
                  verileriGetir('ogrenciler');
                }, const Text('Öğrencileri Getir'), IconsConstans.ogrenciIcon, null),
                const Divider(color: Colors.black, height: 2.0),
                const SizedBox(height: 20),
                const Center(child: Text('Tüm dataları sil')),
                myCustomMenuButton(context, () {
                  _dialogGoster(context);
                }, const Text('Tüm dataları sil'), IconsConstans.warningIcon, Colors.red),
              ],
            )));
  }

  Future<void> verileriGetir(String islem) async {
    String url = '';
    switch (islem) {
      case 'sinif':
        url = ApplicationConstants.sinifUrl;
        break;
      case 'dersler':
        url = ApplicationConstants.dersUrl;
        break;
      case 'ogrenciler':
        url = ApplicationConstants.ogrencilerUrl;
        break;
      case 'temrinler':
        url = ApplicationConstants.temrinUrl;
        break;
      default:
    }

    var raw = await http.get(Uri.parse(url));
    if (raw.statusCode == 200) {
      var jsonFeedback = convert.jsonDecode(raw.body);
      print('jsonFeedback');
      print(jsonFeedback);

      switch (islem) {
        case 'sinif':
          for (var sinif in jsonFeedback) {
            await SinifDatabaseProvider().insertItem(SinifModel(id: sinif['id'], sinifAd: sinif['sinifAd']));
          }
          break;
        case 'dersler':
          for (var ders in jsonFeedback) {
            await DersDatabaseProvider().insertItem(DersModel(id: ders['id'], dersAd: ders['dersAd'], sinifId: ders['sinifId']));
          }
          break;
        case 'temrinler':
          for (var temrin in jsonFeedback) {
            await TemrinDatabaseProvider().insertItem(TemrinModel(id: temrin['id'], temrinKonusu: temrin['temrinKonusu'], dersId: temrin['dersId']));
          }
          break;

        case 'ogrenciler':
          for (var ogrenci in jsonFeedback) {
            await OgrenciDatabaseProvider().insertItem(OgrenciModel(
                id: ogrenci['id'],
                ogrenciAdSoyad: ogrenci['ogrenciName'],
                sinifId: ogrenci['sinifId'],
                ogrenciNu: ogrenci['ogrenciNu'],
                ogrenciResim: ''));
          }
          break;
        default:
      }
    } else if (raw.statusCode == 404) {
      //print('sayfa bulunamadı');
    }
  }
}

Future<void> tumDatalariSil() async {
  List<TemrinModel> temrinList = [];
  List<TemrinNotModel> temrinnotList = [];
  List<OgrenciModel> ogrenciList = [];
  List<SinifModel> sinifList = [];
  List<DersModel> dersList = [];

  temrinnotList = await TemrinNotDatabaseProvider().getList();
  temrinList = await TemrinDatabaseProvider().getList();
  ogrenciList = await OgrenciDatabaseProvider().getList();
  sinifList = await SinifDatabaseProvider().getList();
  dersList = await DersDatabaseProvider().getList();

  for (var sinif in sinifList) {
    SinifDatabaseProvider().removeItem(sinif.id ?? 0);
  }
  print('siniflar silindi');

  for (var ders in dersList) {
    DersDatabaseProvider().removeItem(ders.id ?? 0);
  }
  print('dersler silindi');

  for (var ogrenci in ogrenciList) {
    OgrenciDatabaseProvider().removeItem(ogrenci.id ?? 0);
  }
  print('ogrenciler silindi');

  for (var temrinnot in temrinnotList) {
    TemrinNotDatabaseProvider().removeItem(temrinnot.id ?? 0);
  }
  print('Temrin notlar silindi');

  for (var temrin in temrinList) {
    TemrinDatabaseProvider().removeItem(temrin.id ?? 0);
  }
  print('Temrinler silindi');
}

Future<void> _dialogGoster(BuildContext context) async {
  bool durum = await customDialogFunc(context, 'Dikkatli olun. Eminmisiniz?', 'Tüm datalar silinsin mi?', 'Sil', 'İptal');
  durum ? tumDatalariSil() : "";
}
