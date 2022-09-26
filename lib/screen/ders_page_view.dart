import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/theme/light_theme.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/features/ders/dialog/ders_dialog.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/ders/widget/ders_card.dart';
import 'package:temrinnotuygulamasiiki/widget/loading_center_widget.dart';

class DersPageView extends StatefulWidget {
  const DersPageView({Key? key}) : super(key: key);

  @override
  State<DersPageView> createState() => _DersPageViewState();
}

class _DersPageViewState extends State<DersPageView> {
  List<dynamic> ogrenciList = [];
  List<DersModel> dlist = [];
  List<SinifModel> sinifList = [];
  DersModel dersModel = DersModel();
  late int filtreId = -1;

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
    return BlocProvider(
      create: (context) => DersCubit(databaseProvider: DersDatabaseProvider()),
      child: BlocBuilder<DersCubit, DersState>(builder: (context, state) {
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: customAppBar(
            search: PopupMenuButton<String>(
              color: LighTheme().theme.appBarTheme.shadowColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10))),
              icon: Icon(Icons.filter),
              onCanceled: () {
                filtreId = -1;
                context.read<DersCubit>().dersleriGetir();
              },
              onSelected: (value) {
                print(value);
                filtreId = int.tryParse(value) ?? -1;
                filtreId == -1
                    ? context.read<DersCubit>().dersleriGetir()
                    : context
                        .read<DersCubit>()
                        .filtrelenmisDersleriGetir(filtreId);
              },
              itemBuilder: (BuildContext context) {
                return sinifList.map((e) {
                  return PopupMenuItem(
                      value: e.id.toString(),
                      child: Center(child: Text(e.sinifAd.toString())));
                }).toList();
              },
            ),
            context: context,
            title: state.isLoading
                ? const LoadingCenter()
                : const Text('Ders Listesi'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingActionButton(context),
          body: BlocBuilder<DersCubit, DersState>(
            builder: (context, state) {
              if (state.isCompleted) {
                dlist = state.dersModel ?? [];
                if (dlist.isEmpty) {
                  return const Center(
                    child: Text(
                      'Henüz Ders Yok!',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: dlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DersCard(
                          sinifList: sinifList,
                          transaction: dlist[index],
                          index: index,
                          butons: buildButtons(context, dlist[index]));
                    },
                  );
                }
              } else {
                return const SizedBox(height: 1);
              }
            },
          ),
        );
      }),
    );
  }

  Future addTransaction(int? id, String? dersad, int? sinifId) async {
    dersModel.dersAd = dersad ?? "";
    dersModel.sinifId = sinifId;
    dersModel.id = null;
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.add),
          onPressed: () {
            dersModel.dersAd = null;
            showDialog(
                context: context,
                builder: (context) {
                  return DersDialog(
                    onClickedDone: addTransaction,
                  );
                }).then((value) {
              if (dersModel.dersAd != null) {
                context.read<DersCubit>().dersKaydet(dersModel: dersModel);
              }
            });
          }),
    );
  }

  Widget buildButtons(BuildContext context, DersModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DersDialog(
                    transaction: transaction,
                    onClickedDone: (id, dersad, sinifId) => editTransaction(
                        context, transaction, id ?? 0, dersad, sinifId ?? -1),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Sil'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(context, transaction),
            ),
          )
        ],
      );

  deleteTransaction(BuildContext context, DersModel dersModel) {
    context.read<DersCubit>().dersSil(id: dersModel.id!);
  }

  editTransaction(BuildContext context, DersModel dersModel, int id,
      String dersad, int sinifId) {
    dersModel.id = id;
    dersModel.dersAd = dersad;
    dersModel.sinifId = sinifId;
    context.read<DersCubit>().dersKaydet(id: id, dersModel: dersModel);
  }
}
