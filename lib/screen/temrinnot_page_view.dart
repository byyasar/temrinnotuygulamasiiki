// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_ogrenci_card.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';

class TemrinNotPageView extends StatefulWidget {
  //List<int>? parametreler;
  final TemrinModel temrinModel;
  final DersModel dersModel;
  final SinifModel sinifModel;

  TemrinNotPageView({Key? key, required this.temrinModel, required this.dersModel, required this.sinifModel}) : super(key: key);

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
    temrinListesiniGetir(widget.temrinModel.id!);
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
    //  temrinNotList = await TemrinNotDatabaseProvider().getList();
    temrinNotList = await TemrinNotDatabaseProvider().getFilterList(temrinId);
    print('temrinNotList');
    print('${temrinNotList.length}');
    //print(        "${temrinNotList.first.id}  ${temrinNotList.first.ogrenciId}   ${temrinNotList.first.puanBir} ${temrinNotList.first.puanIki}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemrinNotCubit(databaseProvider: TemrinNotDatabaseProvider()),
      child: Scaffold(
          appBar: customAppBar(
            context: context,
            title: const Text('Temrin Notlar'),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
/*   parametreler: [_secilenSinifId??0,_secilenDersId ??0, _secilenTemrinId ??0], */
                    elevation: 2,
                    child: ListTile(
                        // title: Text('${widget.temrinModel.temrinKonusu} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Sınıf: ${widget.sinifModel.sinifAd}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        title: Text('${widget.dersModel.dersAd}' '\nTemrin Konusu: ${widget.temrinModel.temrinKonusu} ',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  ),
                ),
                Expanded(child: BlocBuilder<TemrinNotCubit, TemrinNotState>(
                  builder: (context, state) {
                    return FutureBuilder(
                      future: OgrenciDatabaseProvider().getFilterList(widget.sinifModel.id!),
                      builder: (BuildContext context, AsyncSnapshot<List<OgrenciModel>> snapshot) {
                        if (snapshot.hasData) {
                          sinifList = snapshot.data!;
                          List<TemrinNotModel>? temrinNotModels = temrinNotList
                              .where(
                                ((element) => element.temrinId == widget.temrinModel.id),
                              )
                              .toList();

                          return BlocListener<TemrinNotCubit, TemrinNotState>(
                            listener: (context, state) {
                              print('State değişti');
                              temrinListesiniGetir(widget.temrinModel.id!);
                            },
                            child: _buildOgrenciListesi(context, temrinNotModels),
                          );
                        } else {
                          return const Text("Datayok");
                        }
                      },
                    );
                  },
                ))
              ],
            ),
          )),
    );
  }

  _buildOgrenciListesi(BuildContext context, List<TemrinNotModel>? temrinNotModels) {
    return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(6),
        itemCount: sinifList.length,
        itemBuilder: ((context, index) {
          TemrinNotModel temrinNotModel =
              temrinNotModels!.firstWhere((element) => element.ogrenciId == sinifList[index].id, orElse: () => TemrinNotModel(id: -1));
          return CustomOgrenciCard(
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
            temrinId: widget.temrinModel.id!,
          );
        }));
  }
}
