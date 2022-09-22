import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/add_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';

class TemrinDialog extends StatefulWidget {
  final TemrinModel? transaction;
  final Function(int? id, String temrinkonusu, int? dersId) onClickedDone;
  //inal Function(TemrinModel) onClickedDone;

  const TemrinDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TemrinDialogState createState() => _TemrinDialogState();
}

class _TemrinDialogState extends State<TemrinDialog> {
  final formKey = GlobalKey<FormState>();
  final temrinkonusuController = TextEditingController();
  int? dersId;
  // DersStore dersStore = DersStore();
  List<DersModel> transactionsDers = [];
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      temrinkonusuController.text = transaction.temrinKonusu ?? "";
    }
    // if (transactionsDers.isEmpty) {
    //   dersListesiniDoldur();
    // }
  }

  @override
  void dispose() {
    temrinkonusuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DersModel> tDers = [];

    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Temrini Düzenle' : 'Temrin Ekle';
    int? sonId;
    isEditing ? dersId = widget.transaction!.dersId : -1;
    sonId = isEditing ? widget.transaction!.id : 0;

    return BlocProvider(
      create: (context) {
        return DersCubit(databaseProvider: DersDatabaseProvider());
      },
      child: BlocBuilder<DersCubit, DersState>(
        builder: (context, state) {
          if (state.isCompleted) {
            //print(state.dersModel);
            tDers = state.dersModel ?? [];
            String selectedItem = "";
            if (isEditing) {
              selectedItem = widget.transaction!.dersId.toString();
              DersModel? sItem = tDers.firstWhere(
                  (element) => element.id == int.tryParse(selectedItem));
              selectedItem = sItem.dersAd ?? "";
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
                      buildtemrinkonusu(),
                      const SizedBox(height: 8),
                      buildDers(context, tDers, selectedItem)
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
                            String? temrinkonusu =
                                temrinkonusuController.text.toUpperCase();
                            //TemrinModel temrinModel = TemrinModel();
                            int? id = sonId;
                            //String temrinKonusu = temrinkonusu;
                           
                            widget.onClickedDone(id, temrinkonusu, dersId);
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

  Widget buildDers(BuildContext context, List<DersModel> transactionsDers,
          String? selectItem) =>
      SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: DropdownSearch<String>(
          //mode: Mode.MENU,
          items: buildItems(transactionsDers),
          selectedItem: selectItem,
          //label: "Sınıflar",
          //hint: "country in menu mode",
          onChanged: (value) {
            //print('seçilen $value');
            int _dersid = transactionsDers
                    .singleWhere((element) => element.dersAd == value)
                    .id ??
                -1;
            dersId = _dersid;
            // setState(() {
            //   dersId = _dersid;
            // });
            // dersStore.setDersId(dersid);
            //print('storedan glen id' + dersid.toString());
          },
          //selectedItem: ,
        ),
      );

  Widget buildtemrinkonusu() => TextFormField(
        controller: temrinkonusuController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Temrin Adını Giriniz',
        ),
        validator: (temrinkonusu) =>
            temrinkonusu != null && temrinkonusu.isEmpty ? 'Temrin Adını' : null,
      );

  List<String> buildItems(List<DersModel> dersModel) {
    // List<String> items = DersBoxes.getTransactions()
    //     .values
    //     .map((e) => e.dersAd.toString())
    //     .toList();
    final items = dersModel.map((e) => e.dersAd.toString()).toList();
    print(items);
    return items;
  }
}
