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

class _TemrinnotPageViewState extends State<TemrinNotPageView> {
  @override
  void initState() {
    super.initState();
    temrinListesiniGetir(widget.parametreler![2]);
  }

  @override
  void dispose() {
    sinifList = [];
    super.dispose();
  }

  Future<void> sinifListesiniGetir(int sinifId) async {
    sinifList = await OgrenciDatabaseProvider().getFilterList(sinifId);
    print('sinifList');
    print(sinifList);
  }

  Future<void> temrinListesiniGetir(int temrinId) async {
    //temrinNotList = await TemrinNotDatabaseProvider().getList();
    temrinNotList = await TemrinNotDatabaseProvider().getFilterList(temrinId);
    print('temrinNotList');
    print('${temrinNotList.length}');
    //print(        "${temrinNotList.first.id}  ${temrinNotList.first.ogrenciId}   ${temrinNotList.first.puanBir} ${temrinNotList.first.puanIki}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Expanded(
                  child: FutureBuilder(
                future: OgrenciDatabaseProvider().getFilterList(widget.parametreler![0]),
                builder: (BuildContext context, AsyncSnapshot<List<OgrenciModel>> snapshot) {
                  if (snapshot.hasData) {
                    sinifList = snapshot.data!;
                    List<TemrinNotModel>? temrinNotModels = temrinNotList
                        .where(
                          ((element) => element.temrinId == widget.parametreler![2]),
                        )
                        .toList();

                    /*
                    
                      SinifModel? sItem = tSinif.firstWhere(
                  (element) => element.id == int.tryParse(selectedItem));



                    */

                    return _buildOgrenciListesi(context, temrinNotModels);
                  } else {
                    return const Text("Datayok");
                  }
                },
              ))
            ],
          ),
        ));
  }

  _buildOgrenciListesi(BuildContext context, List<TemrinNotModel>? temrinNotModels) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(6),
        itemCount: sinifList.length,
        itemBuilder: ((context, index) {
          TemrinNotModel temrinNotModel = temrinNotModels!
              .firstWhere((element) => element.ogrenciId == sinifList[index].id, orElse: () => TemrinNotModel(id: -1));
          return CustomOgrenciCard(
            transaction: sinifList[index],
            index: index,
            //puanController: _puanControllers[index],
            puan: temrinNotModel.id == -1
                ? ""
                : (temrinNotModel.puanBir! +
                        temrinNotModel.puanIki! +
                        temrinNotModel.puanUc! +
                        temrinNotModel.puanDort! +
                        temrinNotModel.puanBes!)
                    .toString(),
            temrinId: widget.parametreler![2],
          );
        }));
  }
}
