import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  List<DersModel> durum = [];
  //late final DersDatabaseProvider dersDatabaseProvider;
  DersModel dersModel = DersModel();

  @override
  void initState() {
    super.initState();
    //dersDatabaseProvider = DersDatabaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DersCubit(databaseProvider: DersDatabaseProvider()),
      child: BlocBuilder<DersCubit, DersState>(builder: (context, state) {
        return Scaffold(
          //appBar: customAppBar(context, 'Database İşlemleri'),
          drawer: buildDrawer(context),
          appBar: customAppBar(
            context,
            state.isLoading ? const LoadingCenter() : const Text('Dersler'),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingActionButton(context),
          // floatingActionButton: FloatingActionButton(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8)),
          //     child: const Icon(Icons.add),
          //     onPressed: () {
          //       showDialog(
          //           context: context,
          //           builder: (context) {
          //             return DersDialog(
          //               onClickedDone: addTransaction,
          //             );
          //           });
          //       DersModel dersModel = DersModel();
          //       dersModel.dersAd = 'Deneme';
          //       context.read<DersCubit>().dersKaydet(dersModel: dersModel);
          //     }),

          body: BlocBuilder<DersCubit, DersState>(
            builder: (context, state) {
              // if (state is DersLoaded) {
              //   List<DersModel> list = [];
              //   list = state.ders ?? [];
              //   return ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Text(list[index].toString());
              //     },
              //   );
              // } else if (state is DersLoading) {
              //   return const Center(child: CircularProgressIndicator());
              // } else if (state is DersFailure) {
              //   return Text('$state hata oluştu');
              if (state.isCompleted) {
                List<DersModel> list = [];
                list = state.dersModel ?? [];
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Text(list[index].toString());
                    return DersCard(
                        transaction: list[index],
                        index: index,
                        butons: buildButtons(context, list[index]));
                  },
                );
              } else {
                return const SizedBox(height: 1);
              }
            },
          ),
        );
      }),
    );
  }

  Future addTransaction(int? id, String? dersad, int sinifId) async {
    //DersModel dersModel = DersModel(id: id, dersAd: dersad, sinifId: sinifId);
    // _dersListesiHelper.addItem(dersModel);
    //await dersDatabaseProvider.open();
    dersModel.dersAd = dersad ?? "";
    dersModel.sinifId = sinifId;
    dersModel.id = null;
    //context.read<DersCubit>().dersKaydet(dersModel: dersModel);
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

            /* DersModel dersModel = DersModel();
            dersModel.dersAd = 'aaa';
            dersModel.sinifId = 2;
            context.read<DersCubit>().dersKaydet(dersModel: dersModel); */
          }),
    );
  }

//context.read<DersCubit>().dersKaydet(dersModel: dersModel);

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
                        context, transaction, id ?? 0, dersad, sinifId),
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



/*


Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.all_inbox),
            onPressed: () async {
              verileriGetir();
              setState(() {});
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.update),
            onPressed: () async {
              //DersDatabaseProvider dersDatabaseProvider = DersDatabaseProvider();
              await dersDatabaseProvider.open();
              DersModel dersModel = DersModel();
              dersModel.dersAd = "yaşar ders";
              dersModel.sinifId = 2;
              dersModel.id = 8;
              DersModel derslist;
              bool durum = await dersDatabaseProvider.updateItem(8, dersModel);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () async {
              //DersDatabaseProvider dersDatabaseProvider = DersDatabaseProvider();
              await dersDatabaseProvider.open();
              bool durum = await dersDatabaseProvider.removeItem(6);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              //DersDatabaseProvider dersDatabaseProvider = DersDatabaseProvider();
              await dersDatabaseProvider.open();
              DersModel dersModel = DersModel();
              dersModel.dersAd = "pc";
              dersModel.sinifId = 2;
              DersModel derslist;
              bool durum = await dersDatabaseProvider.insertItem(dersModel);
              inspect(durum);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.list),
            onPressed: () async {
              await dersDatabaseProvider.open();
              DersModel dersModel;
              int id = 5;
              dersModel = await dersDatabaseProvider.getItem(id);
              inspect(dersModel);
            },
          ),
        ],
      ),
      body: Container(
        //color: Colors.amber,
        child: ListView.builder(
          itemCount: durum.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(
                '${durum[index].id.toString()} - ${durum[index].dersAd ?? ""} - ${durum[index].sinifId.toString()}');
          },
        ),
      ),
    );
 */


/*
Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: const Icon(Icons.all_inbox),
                onPressed: () async {
                  // context.read<DersCubit>().dersleriGetir();
                },
              ),
              FloatingActionButton(
                child: const Icon(Icons.remove),
                onPressed: () async {
                  context.read<DersCubit>().dersSil(id: 3);
                },
              ),
              FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  DersModel dersModel = DersModel();
                  dersModel.dersAd = "pc";
                  dersModel.sinifId = 2;
                  context.read<DersCubit>().dersKaydet(dersModel: dersModel);
                },
              ),
              FloatingActionButton(
                child: const Icon(Icons.list),
                onPressed: () async {
                  DersModel dersModel = DersModel();
                  dersModel.dersAd = "web tasarım";
                  dersModel.sinifId = 2;
                  dersModel.id = 1;
                  context.read<DersCubit>().dersKaydet(dersModel: dersModel);
                  // context.read<DersCubit>().dersKaydet(id: 5, dersModel: dersModel);
                },
              ),
            ],
          ),

 */