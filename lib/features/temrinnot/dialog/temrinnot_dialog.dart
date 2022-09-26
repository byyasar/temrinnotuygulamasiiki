import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/core/widget/add_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrinnot/model/temrinnot_model.dart';

class TemrinNotDialog extends StatefulWidget {
  final TemrinNotModel? transaction;
  final Function(int? id, String temrinnotkonusu, int? dersId) onClickedDone;

  const TemrinNotDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _TemrinNotDialogState createState() => _TemrinNotDialogState();
}

class _TemrinNotDialogState extends State<TemrinNotDialog> {
  final formKey = GlobalKey<FormState>();
  final temrinnotkonusuController = TextEditingController();
  int? dersId;
  List<DersModel> transactionsDers = [];
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      //temrinnotkonusuController.text = transaction.temrinnotKonusu ?? "";
    }
  }

  @override
  void dispose() {
    temrinnotkonusuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DersModel> tDers = [];

    final isEditing = widget.transaction != null;
    final title = isEditing ? 'TemrinNoti Düzenle' : 'TemrinNot Ekle';
    int? sonId;
    //isEditing ? dersId = widget.transaction!.dersId : -1;
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
              // selectedItem = widget.transaction!.dersId.toString();
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
                      buildtemrinnotkonusu(),
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
                            String? temrinnotkonusu =
                                temrinnotkonusuController.text.toUpperCase();
                            int? id = sonId;
                            widget.onClickedDone(id, temrinnotkonusu, dersId);
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
          items: buildItems(transactionsDers),
          selectedItem: selectItem,
          onChanged: (value) {
            int _dersid = transactionsDers
                    .singleWhere((element) => element.dersAd == value)
                    .id ??
                -1;
            dersId = _dersid;
          },
        ),
      );

  Widget buildtemrinnotkonusu() => TextFormField(
        controller: temrinnotkonusuController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'TemrinNot Adını Giriniz',
        ),
        validator: (temrinnotkonusu) =>
            temrinnotkonusu != null && temrinnotkonusu.isEmpty
                ? 'TemrinNot Adını'
                : null,
      );

  List<String> buildItems(List<DersModel> dersModel) {
    final items = dersModel.map((e) => e.dersAd.toString()).toList();
    print(items);
    return items;
  }
}
