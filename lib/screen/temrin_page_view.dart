import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/dialog/temrin_dialog.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/cubit/temrin_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/cubit/temrin_state.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/service/temrin_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/widget/temrin_card.dart';
import 'package:temrinnotuygulamasiiki/widget/loading_center_widget.dart';

class TemrinPageView extends StatefulWidget {
  const TemrinPageView({Key? key}) : super(key: key);

  @override
  State<TemrinPageView> createState() => _TemrinPageViewState();
}

class _TemrinPageViewState extends State<TemrinPageView> {
  List<TemrinModel> durum = [];
  List<DersModel>? dersList = [];
  //late final TemrinDatabaseProvider temrinDatabaseProvider;
  TemrinModel temrinModel = TemrinModel();

  @override
  void initState() {
    super.initState();
    //temrinDatabaseProvider = TemrinDatabaseProvider();
    dersListesiGetir;
  }

  Future<void> get dersListesiGetir async =>
      dersList = await DersDatabaseProvider().getList();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TemrinCubit(databaseProvider: TemrinDatabaseProvider()),
        ),
        /*  BlocProvider(
          create: (context) =>
              DersCubit(databaseProvider: DersDatabaseProvider()),
        ), */
      ],
      child: BlocBuilder<TemrinCubit, TemrinState>(builder: (context, state) {
        return Scaffold(
          //appBar: customAppBar(context, 'Database İşlemleri'),
          drawer: buildDrawer(context),
          appBar: customAppBar(
            context: context,
            title: state.isLoading
                ? const LoadingCenter()
                : const Text('Temrinler'),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingActionButton(context),

          body: BlocBuilder<TemrinCubit, TemrinState>(
            builder: (context, state) {
              if (state.isCompleted) {
                List<TemrinModel> list = [];

                list = state.temrinModel ?? [];
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Text(list[index].toString());

                    return TemrinCard(
                        dersList: dersList,
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

  Future addTransaction(int? id, String? temrinad, int? dersId) async {
    //TemrinModel temrinModel = TemrinModel(id: id, temrinAd: temrinad, dersId: dersId);
    // _temrinListesiHelper.addItem(temrinModel);
    //await temrinDatabaseProvider.open();
    temrinModel.temrinKonusu = temrinad ?? "";
    temrinModel.dersId = dersId;
    temrinModel.id = null;
    //context.read<TemrinCubit>().temrinKaydet(temrinModel: temrinModel);
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: FloatingActionButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.add),
          onPressed: () {
            temrinModel.temrinKonusu = null;
            showDialog(
                context: context,
                builder: (context) {
                  return TemrinDialog(
                    onClickedDone: addTransaction,
                  );
                }).then((value) {
              if (temrinModel.temrinKonusu != null) {
                context
                    .read<TemrinCubit>()
                    .temrinKaydet(temrinModel: temrinModel);
              }
            });

            /* TemrinModel temrinModel = TemrinModel();
            temrinModel.temrinAd = 'aaa';
            temrinModel.dersId = 2;
            context.read<TemrinCubit>().temrinKaydet(temrinModel: temrinModel); */
          }),
    );
  }

//context.read<TemrinCubit>().temrinKaydet(temrinModel: temrinModel);

  Widget buildButtons(BuildContext context, TemrinModel transaction) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TemrinDialog(
                    transaction: transaction,
                    onClickedDone: (id, temrinad, dersId) => editTransaction(
                        context, transaction, id ?? 0, temrinad, dersId ?? -1),
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

  deleteTransaction(BuildContext context, TemrinModel temrinModel) {
    context.read<TemrinCubit>().temrinSil(id: temrinModel.id!);
  }

  editTransaction(BuildContext context, TemrinModel temrinModel, int id,
      String temrinKonusu, int dersId) {
    temrinModel.id = id;
    temrinModel.temrinKonusu = temrinKonusu;
    temrinModel.dersId = dersId;
    context.read<TemrinCubit>().temrinKaydet(id: id, temrinModel: temrinModel);
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
              //TemrinDatabaseProvider temrinDatabaseProvider = TemrinDatabaseProvider();
              await temrinDatabaseProvider.open();
              TemrinModel temrinModel = TemrinModel();
              temrinModel.temrinAd = "yaşar temrin";
              temrinModel.dersId = 2;
              temrinModel.id = 8;
              TemrinModel temrinlist;
              bool durum = await temrinDatabaseProvider.updateItem(8, temrinModel);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () async {
              //TemrinDatabaseProvider temrinDatabaseProvider = TemrinDatabaseProvider();
              await temrinDatabaseProvider.open();
              bool durum = await temrinDatabaseProvider.removeItem(6);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              //TemrinDatabaseProvider temrinDatabaseProvider = TemrinDatabaseProvider();
              await temrinDatabaseProvider.open();
              TemrinModel temrinModel = TemrinModel();
              temrinModel.temrinAd = "pc";
              temrinModel.dersId = 2;
              TemrinModel temrinlist;
              bool durum = await temrinDatabaseProvider.insertItem(temrinModel);
              inspect(durum);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.list),
            onPressed: () async {
              await temrinDatabaseProvider.open();
              TemrinModel temrinModel;
              int id = 5;
              temrinModel = await temrinDatabaseProvider.getItem(id);
              inspect(temrinModel);
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
                '${durum[index].id.toString()} - ${durum[index].temrinAd ?? ""} - ${durum[index].dersId.toString()}');
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
                  // context.read<TemrinCubit>().temrinleriGetir();
                },
              ),
              FloatingActionButton(
                child: const Icon(Icons.remove),
                onPressed: () async {
                  context.read<TemrinCubit>().temrinSil(id: 3);
                },
              ),
              FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () async {
                  TemrinModel temrinModel = TemrinModel();
                  temrinModel.temrinAd = "pc";
                  temrinModel.dersId = 2;
                  context.read<TemrinCubit>().temrinKaydet(temrinModel: temrinModel);
                },
              ),
              FloatingActionButton(
                child: const Icon(Icons.list),
                onPressed: () async {
                  TemrinModel temrinModel = TemrinModel();
                  temrinModel.temrinAd = "web tasarım";
                  temrinModel.dersId = 2;
                  temrinModel.id = 1;
                  context.read<TemrinCubit>().temrinKaydet(temrinModel: temrinModel);
                  // context.read<TemrinCubit>().temrinKaydet(id: 5, temrinModel: temrinModel);
                },
              ),
            ],
          ),

 */