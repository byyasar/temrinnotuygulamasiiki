import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/widget/build_drawer.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_appbar.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/cubit/ogrenci_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/cubit/ogrenci_state.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/dialog/ogrenci_dialog.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/service/ogrenci_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/widget/ogrenci_card.dart';
import 'package:temrinnotuygulamasiiki/widget/loading_center_widget.dart';

class OgrenciPageView extends StatefulWidget {
  const OgrenciPageView({Key? key}) : super(key: key);

  @override
  _OgrenciPageViewState createState() => _OgrenciPageViewState();
}

class _OgrenciPageViewState extends State<OgrenciPageView> {
  List<dynamic> ogrenciList = [];
  OgrenciModel ogrenciModel = OgrenciModel();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OgrenciCubit(databaseProvider: OgrenciDatabaseProvider()),
      child: BlocBuilder<OgrenciCubit, OgrenciState>(builder: (context, state) {
        return Scaffold(
          drawer: buildDrawer(context),
          appBar: customAppBar(
              context:context,
              title:state.isLoading
                  ? const LoadingCenter()
                  : const Text('TNS-Öğrenci Listesi')),
          body: _buildBody,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFloatingAcionButton(context),
        );
      }),
    );
  }

  get _buildBody {
    return BlocBuilder<OgrenciCubit, OgrenciState>(
      builder: (context, state) {
        if (state.isCompleted) {
          List<OgrenciModel> list = [];
          list = state.ogrenciModel ?? [];
          if (list.isEmpty) {
            return const Center(
              child: Text(
                'Henüz Ogrenci yok!',
                style: TextStyle(fontSize: 24),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                //Text(list[index].toString());
                return OgrenciCard(
                    transaction: list[index],
                    index: index,
                    butons: buildButtons(context, list[index]));
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
          ogrenciModel.ogrenciAdSoyad = null;
          showDialog(
            context: context,
            builder: (context) => OgrenciDialog(
              onClickedDone: addTransaction,
            ),
          ).then((value) {
            if (ogrenciModel.ogrenciAdSoyad != null) {
              context
                  .read<OgrenciCubit>()
                  .ogrenciKaydet(ogrenciModel: ogrenciModel);
            }
          });
        },
      ),
    );
  }

  Widget buildTransaction(
      BuildContext context, OgrenciModel ogrenciModel, int index) {
    return OgrenciCard(
        transaction: ogrenciModel,
        index: index,
        butons: buildButtons(context, ogrenciModel));
  }

  Future addTransaction(int? id, String? ogrenciAd, int? ogrenciNu,
      int? sinifId, String? ogrenciResim) async {
    ogrenciModel.ogrenciAdSoyad = ogrenciAd ?? "";
    ogrenciModel.id = null;
    ogrenciModel.ogrenciNu = ogrenciNu;
    ogrenciModel.sinifId = sinifId;
    ogrenciModel.ogrenciResim = ogrenciResim;
  }

  Widget buildButtons(BuildContext context, OgrenciModel ogrenciModel) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Düzenle'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OgrenciDialog(
                    transaction: ogrenciModel,
                    onClickedDone: (id, ogrenciAdSoyad, ogrenciNu, sinifId,
                            ogrenciResim) =>
                        editTransaction(
                            context,
                            ogrenciModel,
                            id ?? 0,
                            ogrenciAdSoyad,
                            ogrenciNu ?? 0,
                            sinifId ?? -1,
                            ogrenciResim ?? ""),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Sil'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(context, ogrenciModel),
            ),
          )
        ],
      );

  deleteTransaction(BuildContext context, OgrenciModel ogrenciModel) {
    context.read<OgrenciCubit>().ogrenciSil(id: ogrenciModel.id!);
  }

  editTransaction(BuildContext context, OgrenciModel ogrenciModel, int id,
      String name, int ogrenciNu, int sinifId, String ogrenciResim) {
    ogrenciModel.id = id;
    ogrenciModel.ogrenciAdSoyad = name;
    ogrenciModel.ogrenciNu = ogrenciNu;
    ogrenciModel.sinifId = sinifId;
    ogrenciModel.ogrenciResim = ogrenciResim;
    context
        .read<OgrenciCubit>()
        .ogrenciKaydet(id: id, ogrenciModel: ogrenciModel);
  }
}
