// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_ogrenci_card.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';

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

class _TemrinnotPageViewState extends State<TemrinNotPageView> {
  @override
  void initState() {
    super.initState();
    sinifListesiniGetir(widget.parametreler ?? []);
  }

  Future<void> sinifListesiniGetir(List<int> parametreler) async {
    sinifList = await OgrenciDatabaseProvider().getFilterList(parametreler[0]);
    print(sinifList);
    // DersModel tumuModel = DersModel(id: -1, dersAd: "Tüm Dersler");
    // dersList.insert(0, tumuModel);
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
          child: ListView.builder(
              itemCount: sinifList.length,
              itemBuilder: ((context, index) {
                _puanlar[index] = int.parse(
                    _puanControllers[index].text.isEmpty || _puanControllers[index].text.toUpperCase() == 'G'
                        ? '-1'
                        : _puanControllers[index].text);

                return CustomOgrenciCard(
                    transaction: sinifList[index],
                    index: index,
                    puanController: _puanControllers[index],
                    temrinId: widget.parametreler![2],
                    parametreler: widget.parametreler!,
                    kriterler: widget.parametreler);
              })),
        ));
  }
}
