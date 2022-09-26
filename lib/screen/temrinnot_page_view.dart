import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/cubit/temrinnot_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/dialog/temrinnot_dialog.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/service/temrinnot_database_provider.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:temrinnotuygulamasiiki/widget/loading_center_widget.dart';

class TemrinNotPageView extends StatefulWidget {
  const TemrinNotPageView({Key? key}) : super(key: key);

  @override
  State<TemrinNotPageView> createState() => _TemrinnotPageViewState();
}

class _TemrinnotPageViewState extends State<TemrinNotPageView> {
  List<TemrinNotModel> durum = [];
  List<DersModel> dersList = [];
  TemrinNotModel temrinnotModel = TemrinNotModel();
  late int filtreId = -1;
  @override
  void initState() {
    super.initState();
    dersListesiGetir;
  }

  Future<void> get dersListesiGetir async {
    dersList = await DersDatabaseProvider().getList();
    DersModel tumuModel = DersModel(id: -1, dersAd: "Tüm Dersler");
    dersList.insert(0, tumuModel);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemrinNotCubit(databaseProvider: TemrinNotDatabaseProvider()),
      child: BlocBuilder<TemrinNotCubit, TemrinNotState>(
          builder: (context, state) {
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: customAppBar(
            context: context,
            title: state.isLoading
                ? const LoadingCenter()
                : const Text('Temrinnotler'),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingActionButton(context),
          body: BlocBuilder<TemrinNotCubit, TemrinNotState>(
            builder: (context, state) {
              if (state.isCompleted) {
                List<TemrinNotModel> list = [];

                list = state.temrinNotModel ?? [];
                if (list.isEmpty) {
                  return const Center(
                    child: Text(
                      'Henüz Temrinnot Yok!',
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(list[index].id.toString());
                      /* return TemrinNotCard(
                            dersList: dersList,
                            transaction: list[index],
                            index: index,
                            butons: buildButtons(context, list[index])); */
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

  Future addTransaction(int? id, String? temrinnotad, int? dersId) async {
    /*  temrinnotModel.temrinnotKonusu = temrinnotad ?? "";
    temrinnotModel.dersId = dersId;
    temrinnotModel.id = null; */
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.add),
          onPressed: () {
            //temrinnotModel.temrinnotKonusu = null;
            showDialog(
                context: context,
                builder: (context) {
                  return TemrinNotDialog(
                    onClickedDone: addTransaction,
                  );
                }).then((value) {
              if (temrinnotModel.aciklama != null) {
                context
                    .read<TemrinNotCubit>()
                    .temrinnotKaydet(temrinnotModel: temrinnotModel);
              }
            });
          }),
    );
  }

//context.read<TemrinnotCubit>().temrinnotKaydet(temrinnotModel: temrinnotModel);

  Widget buildButtons(BuildContext context, TemrinNotModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TemrinNotDialog(
                    transaction: transaction,
                    onClickedDone: (id, temrinnotad, dersId) => editTransaction(
                        context,
                        transaction,
                        id ?? 0,
                        temrinnotad,
                        dersId ?? -1),
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

  deleteTransaction(BuildContext context, TemrinNotModel temrinnotModel) {
    context.read<TemrinNotCubit>().temrinnotSil(id: temrinnotModel.id!);
  }

  editTransaction(BuildContext context, TemrinNotModel temrinnotModel, int id,
      String temrinnotKonusu, int dersId) {
    temrinnotModel.id = id;
    // temrinnotModel.temrinnotKonusu = temrinnotKonusu;
    // temrinnotModel.dersId = dersId;
    context
        .read<TemrinNotCubit>()
        .temrinnotKaydet(id: id, temrinnotModel: temrinnotModel);
  }
}
