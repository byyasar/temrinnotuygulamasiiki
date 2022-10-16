// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';

class OgrenciPuanListPageView extends StatefulWidget {
  final int sinifId;
  final int dersId;
//  final int ogrenciId;
  final OgrenciModel ogrenciModel;

  OgrenciPuanListPageView({
    Key? key,
    required this.sinifId,
    required this.dersId,
    required this.ogrenciModel,
  }) : super(key: key);

  @override
  State<OgrenciPuanListPageView> createState() => _OgrenciPuanListPageViewState();
}

List<TemrinModel> temrinList = [];
List<int> toplam = [];

class _OgrenciPuanListPageViewState extends State<OgrenciPuanListPageView> {
  @override
  void initState() {
    super.initState();
    temrinListesiniGetir(widget.dersId);
  }

  @override
  void dispose() {
    toplam = [];
    super.dispose();
  }

  Future<void> temrinListesiniGetir(int dersId) async {
    temrinList = await TemrinDatabaseProvider().getFilterListItemParameter(dersId);
    print('temrinList');
    print('${temrinList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemrinNotCubit(databaseProvider: TemrinNotDatabaseProvider(), ogrenciId: widget.ogrenciModel.id),
      child: Scaffold(
          appBar: customAppBar(
            context: context,
            title: const Text('Öğrenci Puanları'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: BlocBuilder<TemrinNotCubit, TemrinNotState>(
            builder: (context, state) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ogrenciCard(context),
                    BlocBuilder<TemrinNotCubit, TemrinNotState>(
                      builder: (context, state) {
                        if (state.isCompleted) {
                          print('state');
                          print(state);
                          List<TemrinNotModel> liste = state.temrinNotModel ?? [];
                          return Expanded(child: _buildOgrenciNotListesi(context, liste));
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget _ogrenciCard(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: ListTile(
          trailing: Column(
            children: [
              const Text('Ortalama'),
              CircleAvatar(backgroundColor: Colors.yellow, radius: 18, child: Text('${toplam.isEmpty ? "-" : ortalama()}')),
            ],
          ),
          subtitle: Text('Nu: ${widget.ogrenciModel.ogrenciNu} - Sınıfı: ${widget.ogrenciModel.sinifId}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          title: Text('${widget.ogrenciModel.ogrenciAdSoyad}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
                child: Text('${_puan == -5 ? 'G' : _puan}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              title: Text('${temrinList.singleWhere((element) => element.id == data[index].temrinId).temrinKonusu} '),
              //subtitle: Text('key: ${data[index].key} Tid ${data[index].temrinId} puan ${data[index].puan}'),
              subtitle: Text('Notlar: ${data[index].aciklama}'),
            ),
          );
        });
  }

  double ortalama() {
    double ortalama = 0;
    for (var t in toplam) {
      ortalama += t;
    }
    print(ortalama / toplam.length);
    return ortalama / toplam.length;
  }

  int puanHesapla(TemrinNotModel temrinNotModel) {
    int puan = ((temrinNotModel.puanBir ?? 0) +
        (temrinNotModel.puanIki ?? 0) +
        (temrinNotModel.puanUc ?? 0) +
        (temrinNotModel.puanDort ?? 0) +
        (temrinNotModel.puanBes ?? 0));
    if (puan > -5) {
      toplam.add(puan);
    }
    return puan;
  }
}