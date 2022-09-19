import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_state.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/dialog/sinif_dialog.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/widget/sinif_card.dart';
import 'package:temrinnotuygulamasiiki/widget/loading_center_widget.dart';

class SinifPageView extends StatefulWidget {
  const SinifPageView({Key? key}) : super(key: key);

  @override
  _SinifPageViewState createState() => _SinifPageViewState();
}

class _SinifPageViewState extends State<SinifPageView> {
  List<dynamic> sinifList = [];
  SinifModel sinifModel = SinifModel();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SinifCubit(databaseProvider: SinifDatabaseProvider()),
      child: BlocBuilder<SinifCubit, SinifState>(builder: (context, state) {
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: customAppBar(context, state.isLoading ? const LoadingCenter() : const Text('TNS-Sınıf Listesi')),
          body: _buildBody,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingAcionButton(context),
        );
      }),
    );
  }

  get _buildBody {
    return BlocBuilder<SinifCubit, SinifState>(
      builder: (context, state) {
        if (state.isCompleted) {
          List<SinifModel> list = [];
          list = state.sinifModel ?? [];
          if (list.isEmpty) {
            return const Center(
              child: Text(
                'Henüz Sinif yok!',
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                //Text(list[index].toString());
                return SinifCard(transaction: list[index], index: index, butons: buildButtons(context, list[index]));
              },
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Padding _buildFloatingAcionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.add),
        onPressed: () {
          sinifModel.sinifAd = null;
          showDialog(
            context: context,
            builder: (context) => SinifDialog(
              onClickedDone: addTransaction,
            ),
          ).then((value) {
            if (sinifModel.sinifAd != null) {
              context.read<SinifCubit>().sinifKaydet(sinifModel: sinifModel);
            }
          });
        },
      ),
    );
  }

  // Widget buildContent(List<SinifModel> transactions) {
  //   if (transactions.isEmpty) {
  //     return const Center(
  //       child: Text(
  //         'Henüz Sinif yok!',
  //         style: TextStyle(fontSize: 24),
  //       ),
  //     );
  //   } else {
  //     //return Text(transactions.length.toString());
  //     return Column(
  //       children: [
  //         const SizedBox(height: 24),
  //         Expanded(
  //           child: ListView.builder(
  //             padding: const EdgeInsets.all(8),
  //             itemCount: transactions.length,
  //             itemBuilder: (BuildContext context, int index) {
  //               final transaction = transactions[index];

  //               return buildTransaction(context, transaction, index);
  //               //return Text(transactions.length.toString());
  //             },
  //           ),
  //         ),
  //         const SizedBox(height: 24),
  //       ],
  //     );
  //   }
  // }

  Widget buildTransaction(BuildContext context, SinifModel sinifModel, int index) {
    return SinifCard(transaction: sinifModel, index: index, butons: buildButtons(context, sinifModel));
  }

  Future addTransaction(int? id, String? sinifAd) async {
    //final sinifModel = SinifModel(id: id, sinifAd: sinifAd);
    sinifModel.sinifAd = sinifAd ?? "";
    sinifModel.id = null;
  }

  Widget buildButtons(BuildContext context, SinifModel sinifModel) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SinifDialog(
                    transaction: sinifModel,
                    onClickedDone: (id, sinifAd) => editTransaction(context, sinifModel, id, sinifAd),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Sil'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(context, sinifModel),
            ),
          )
        ],
      );

  deleteTransaction(BuildContext context, SinifModel sinifModel) {
    context.read<SinifCubit>().sinifSil(id: sinifModel.id!);
  }

  editTransaction(BuildContext context, SinifModel sinifModel, int? id, String sinifAd) {
    sinifModel.id = id;
    sinifModel.sinifAd = sinifAd;
    context.read<SinifCubit>().sinifKaydet(id: id, sinifModel: sinifModel);
  }
}
