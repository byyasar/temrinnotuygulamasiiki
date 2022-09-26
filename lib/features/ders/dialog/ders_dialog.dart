import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/add_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_state.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';

class DersDialog extends StatefulWidget {
  final DersModel? transaction;
  final Function(int? id, String dersad, int? sinifId) onClickedDone;

  const DersDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _DersDialogState createState() => _DersDialogState();
}

class _DersDialogState extends State<DersDialog> {
  final formKey = GlobalKey<FormState>();
  final dersadController = TextEditingController();
  int? sinifId;
  List<SinifModel> transactionsSinif = [];
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      dersadController.text = transaction.dersAd ?? "";
    }
  }

  @override
  void dispose() {
    dersadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SinifModel> tSinif = [];

    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Dersi Düzenle' : 'Ders Ekle';
    int? sonId;
    isEditing ? sinifId = widget.transaction!.sinifId : -1;
    sonId = isEditing ? widget.transaction!.id : 0;

    return BlocProvider(
      create: (context) {
        return SinifCubit(databaseProvider: SinifDatabaseProvider());
      },
      child: BlocBuilder<SinifCubit, SinifState>(
        builder: (context, state) {
          if (state.isCompleted) {
            //print(state.sinifModel);
            tSinif = state.sinifModel ?? [];
            String selectedItem = "";
            if (isEditing) {
              selectedItem = widget.transaction!.sinifId.toString();
              SinifModel? sItem = tSinif.firstWhere(
                  (element) => element.id == int.tryParse(selectedItem));
              selectedItem = sItem.sinifAd ?? "";
            }
            return AlertDialog(
              title: Text(title),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 8),
                      builddersad(),
                      const SizedBox(height: 1),
                      const Text('Sınıf Seçiniz'),
                      buildSinif(context, tSinif, selectedItem)
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCancelButton(context),
                    const SizedBox(width: 10),
                    BuildAddButton(
                        context: context,
                        sonId: sonId,
                        isEditing: isEditing,
                        onPressed: () async {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            String? dersad =
                                dersadController.text.toUpperCase();
                            int? id = sonId;
                            widget.onClickedDone(id, dersad, sinifId);
                            Navigator.of(context)
                                .pop(); //todo: navigator pop return value
                          }
                        }),
                  ],
                ),
              ],
            );
          } else {
            return const SizedBox(height: 1);
          }
        },
      ),
    );
  }

  Widget buildSinif(BuildContext context, List<SinifModel> transactionsSinif,
          String? selectItem) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          items: buildItems(transactionsSinif),
          selectedItem: selectItem,
          onChanged: (value) {
            int _sinifid = transactionsSinif
                    .singleWhere((element) => element.sinifAd == value)
                    .id ??
                -1;
            sinifId = _sinifid;
          },
        ),
      );

  Widget builddersad() => TextFormField(
        controller: dersadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Ders Adını Giriniz',
        ),
        validator: (dersad) =>
            dersad != null && dersad.isEmpty ? 'Ders Adını' : null,
      );

  List<String> buildItems(List<SinifModel> sinifModel) {
    final items = sinifModel.map((e) => e.sinifAd.toString()).toList();
    return items;
  }
}
