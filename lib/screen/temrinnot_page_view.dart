// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_ogrenci_card.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';

class TemrinNotPageView extends StatefulWidget {
  List<int>? parametreler;

  TemrinNotPageView({Key? key, required this.parametreler}) : super(key: key);

  @override
  State<TemrinNotPageView> createState() => _TemrinnotPageViewState();
}

/*   parametreler: [_secilenSinifId??0,_secilenDersId ??0, _secilenTemrinId ??0], */
List<TemrinNotModel> temrinNotList = [];
List<OgrenciModel> sinifList = [];
List<TextEditingController> _puanControllers = [];
List<int> _puanlar = [];
List<List<int>> _kriterler = [];

class _TemrinnotPageViewState extends State<TemrinNotPageView> {
  @override
  void initState() {
    super.initState();
    sinifListesiniGetir(widget.parametreler ?? []);
  }

  Future<void> sinifListesiniGetir(List<int> parametreler) async {
    sinifList = await OgrenciDatabaseProvider().getFilterList(parametreler[0]);
    temrinNotList = await TemrinNotDatabaseProvider()
        .getFilterListParameter(parametreler[1], parametreler[2]);

    print(sinifList);
    // DersModel tumuModel = DersModel(id: -1, dersAd: "Tüm Dersler");
    // dersList.insert(0, tumuModel);

    _puanControllers = [];
    _puanlar = [];
    _kriterler = [];

    /*   for (var i = 0; i < temrinNotList.length; i++) {
      _puanlar.add(0);
      _kriterler.add([0, 0, 0, 0, 0]);
      temrinNotList.map((e) {
        if (e.ogrenciId == sinifList[i].id) {
          _puanControllers[i].text =
              e.puanBir == -1 ? 'G' : e.puanBir.toString();
          //_aciklamaControllers[item.id].text = item.notlar;
          //_kriterler[i] = e.puanBir;
        } else {}
      }).toList();
    } */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: buildDrawer(context),
        appBar: customAppBar(
          context: context,
          title: const Text('Temrinnotler'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 25,
                  color: Colors.amber,
                  child: Text("${widget.parametreler?[0].toString()}"),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(6),
                  itemCount: sinifList.length,
                  itemBuilder: ((context, index) {
                    return CustomOgrenciCard(
                      transaction: sinifList[index],
                      index: index,
                      //puanController: _puanControllers[index],
                      temrinId: widget.parametreler![2],
                    );
                  })),
            ],
          ),
        ));
  }
}
