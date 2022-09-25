import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/add_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/cubit/sinif_state.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/service/sinif_database_provider.dart';

class OgrenciDialog extends StatefulWidget {
  final OgrenciModel? transaction;

  final Function(int? id, String ogrenciAdSoyad, int? ogrenciNu, int? sinifId, String? ogrenciResim) onClickedDone;

  const OgrenciDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _OgrenciDialogState createState() => _OgrenciDialogState();
}

class _OgrenciDialogState extends State<OgrenciDialog> {
  final formKey = GlobalKey<FormState>();
  final ogrenciadController = TextEditingController();
  final nuController = TextEditingController();
  int? sinifId;

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      ogrenciadController.text = transaction.ogrenciAdSoyad ?? "";
      nuController.text = transaction.ogrenciNu.toString();
    }
  }

  @override
  void dispose() {
    ogrenciadController.dispose();
    nuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SinifModel> tSinif = [];

    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Öğrenciyi Düzenle' : 'Öğrenci Ekle';
    int? sonId;
    isEditing ? sonId = widget.transaction!.id : 0;
    isEditing ? sinifId = widget.transaction!.sinifId : -1;

    return BlocProvider(
      create: (context) {
        return SinifCubit(databaseProvider: SinifDatabaseProvider());
      },
      child: BlocBuilder<SinifCubit, SinifState>(
        builder: (context, state) {
          if (state.isCompleted) {
            tSinif = state.sinifModel ?? [];
            String selectedItem = "";
            if (isEditing && selectedItem.isNotEmpty) {
              selectedItem = widget.transaction!.sinifId.toString();
              SinifModel? sItem = tSinif.firstWhere((element) => element.id == int.tryParse(selectedItem));
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
                      buildOgrenciad(),
                      const SizedBox(height: 8),
                      buildNu(),
                      const SizedBox(height: 8),
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
                          String? ogrenciAdSoyad = ogrenciadController.text.toUpperCase();
                          // int? nu = int.parse(nuController.text);
                          int? id = sonId;
                          //int? sinifID = sinifId;
                          int? ogrenciNu = int.parse(nuController.text);
                          String? ogrenciResim = "";

                          widget.onClickedDone(id, ogrenciAdSoyad, ogrenciNu, sinifId, ogrenciResim);
                          Navigator.of(context).pop();
                        }
                      },
                    ),
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

  Widget buildSinif(BuildContext context, List<SinifModel> transactionsSinif, String? selectItem) => SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          //mode: Mode.MENU,
          items: buildItems(transactionsSinif),
          selectedItem: selectItem,
          //label: "Sınıflar",
          //hint: "country in menu mode",
          onChanged: (value) {
            //print('seçilen $value');
            int _sinifid = transactionsSinif.singleWhere((element) => element.sinifAd == value).id ?? -1;

            sinifId = _sinifid;

            // sinifStore.setSinifId(sinifid);
            //print('storedan glen id' + sinifid.toString());
          },
          //selectedItem: ,
        ),
      );

  Widget buildOgrenciad() => TextFormField(
        controller: ogrenciadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Öğrenci Adını Giriniz',
        ),
        validator: (ogrenciAd) => ogrenciAd != null && ogrenciAd.isEmpty ? 'Öğrenci Adını Yazınız' : null,
      );

  Widget buildNu() => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Öğrenci Nu"),
          hintText: 'Numarayı Giriniz',
        ),
        keyboardType: TextInputType.number,
        validator: (name) => name != null && name.isEmpty ? 'Nu' : null,
        controller: nuController,
      );

  List<String> buildItems(List<SinifModel> sinifModel) {
    final items = sinifModel.map((e) => e.sinifAd.toString()).toList();
    print(items);
    return items;
  }
}
