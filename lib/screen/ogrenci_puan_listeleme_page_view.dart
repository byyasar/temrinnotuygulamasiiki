// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';

class OgrenciPuanListPageView extends StatefulWidget {
  final int sinifId;
  final int dersId;
  final int ogrenciId;

  OgrenciPuanListPageView({
    Key? key,
    required this.sinifId,
    required this.dersId,
    required this.ogrenciId,
  }) : super(key: key);

  @override
  State<OgrenciPuanListPageView> createState() => _OgrenciPuanListPageViewState();
}

/*   parametreler: [_secilenSinifId??0,_secilenDersId ??0, _secilenTemrinId ??0], */
List<TemrinNotModel> ogrenciTemrinNotList = [];
List<TemrinModel> temrinList = [];

class _OgrenciPuanListPageViewState extends State<OgrenciPuanListPageView> {
  @override
  void initState() {
    super.initState();
    temrinListesiniGetir(widget.dersId);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ogrenciTemrinNotList = [];
    super.dispose();
  }

  Future<void> temrinListesiniGetir(int dersId) async {
    temrinList = await TemrinDatabaseProvider().getFilterListItemParameter(dersId);
    print('temrinList');
    print('${temrinList.length}');
    //await ogrenciTemrinNotListesiniGetir(temrinList, widget.ogrenciId);
  }

  Future<void> ogrenciTemrinNotListesiniGetir(List<TemrinModel> temrinsList, int ogrenciId) async {
    ogrenciTemrinNotList = [];
    for (var temrin in temrinsList) {
      var response = await TemrinNotDatabaseProvider().getFilterItemParameter(widget.ogrenciId, temrin.id!);
      //var response = context.read<TemrinNotCubit>().filtrelenmisTemrinNotGetir(temrin.id!, widget.ogrenciId);

      if (response.id != null) {
        ogrenciTemrinNotList.add(response);
        print(response.toString());
      }
    }
    //setState(() {});
    /*  print('ogrenciTemrinNotList');
    print('${ogrenciTemrinNotList.length}'); */
  }

  @override
  Widget build(BuildContext context) {
    ogrenciTemrinNotListesiniGetir(temrinList, widget.ogrenciId);
    return BlocProvider(
      create: (context) => TemrinNotCubit(databaseProvider: TemrinNotDatabaseProvider()),
      child: Scaffold(
          appBar: customAppBar(
            context: context,
            title: const Text('Öğrenci Puanları'),
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
                    child: Text("${widget.dersId.toString()}"),
                  ),
                ),
                BlocBuilder<TemrinNotCubit, TemrinNotState>(
                  builder: (context, state) {
                    if (state.isCompleted) {
                      print('state');
                      print(state);

                      return Expanded(child: _buildOgrenciNotListesi(context, ogrenciTemrinNotList));
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          )),
    );
  }

  Widget _buildOgrenciNotListesi(BuildContext context, List<TemrinNotModel> data) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          int _puan = puanHesapla(data[index]);
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(radius: 12, child: Text('${index + 1}')),
              trailing: CircleAvatar(
                backgroundColor: _puan <= 0 ? Colors.red : Colors.yellow,
                child: Text('${_puan == -1 ? 'G' : _puan}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              title: Text('${temrinList.singleWhere((element) => element.id == data[index].temrinId).temrinKonusu} '),
              //subtitle: Text('key: ${data[index].key} Tid ${data[index].temrinId} puan ${data[index].puan}'),
              subtitle: Text('Notlar: ${data[index].aciklama}'),
            ),
          );
        });
  }

  int puanHesapla(TemrinNotModel temrinNotModel) {
    int puan = ((temrinNotModel.puanBir ?? 0) +
        (temrinNotModel.puanIki ?? 0) +
        (temrinNotModel.puanUc ?? 0) +
        (temrinNotModel.puanDort ?? 0) +
        (temrinNotModel.puanBes ?? 0));
    return puan;
  }

  /*  _buildOgrenciListesi(BuildContext context, List<TemrinNotModel>? temrinNotModels) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(6),
        itemCount: temrinList.length,
        itemBuilder: ((context, index) {
          TemrinNotModel temrinNotModel =
              temrinNotModels!.firstWhere((element) => element.ogrenciId == sinifList[index].id, orElse: () => TemrinNotModel(id: -1));
          return Text('data');
          /* return CustomOgrenciCard(
            transaction: sinifList[index],
            index: index,
            //puanController: _puanControllers[index],
            puan: temrinNotModel.id == -1
                ? ""
                : ((temrinNotModel.puanBir ?? 0) +
                        (temrinNotModel.puanIki ?? 0) +
                        (temrinNotModel.puanUc ?? 0) +
                        (temrinNotModel.puanDort ?? 0) +
                        (temrinNotModel.puanBes ?? 0))
                    .toString(),
            temrinId: widget.parametreler![2],
          ); */
        }));
  } */
}
