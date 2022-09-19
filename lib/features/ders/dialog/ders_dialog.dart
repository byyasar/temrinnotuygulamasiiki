import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:temrinnotuygulamasiiki/core/widget/add_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';

class DersDialog extends StatefulWidget {
  final DersModel? transaction;
  final Function(int? id, String dersad, int sinifId) onClickedDone;
  //inal Function(DersModel) onClickedDone;

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
  // SinifStore sinifStore = SinifStore();
  // List<SinifModel> transactionsSinif = [];
  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      dersadController.text = transaction.dersAd.toString();
    }
    // if (transactionsSinif.isEmpty) {
    //   transactionsSinif =
    //       SinifBoxes.getTransactions().values.toList().cast<SinifModel>();
    // }
  }

  @override
  void dispose() {
    dersadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Dersi Düzenle' : 'Ders Ekle';
    //final box = DersBoxes.getTransactions();
    int? sonId;
    sonId = isEditing ? widget.transaction!.id : 0;
    /*if (widget.transaction?.id == null) {
      isEditing
          ? sonId = widget.transaction!.id
          : (box.values.isEmpty ? sonId = 1 : sonId = box.values.last.id + 1);
    } else {
      sonId = isEditing ? widget.transaction!.id : 1;
      sinifStore.setSinifId(widget.transaction!.sinifId);
      sinifStore.setSinifAd(transactionsSinif
          .singleWhere((element) => element.id == widget.transaction!.sinifId)
          .sinifAd);
    }*/
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
              const SizedBox(height: 8),
              //buildSinif(context, transactionsSinif)
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
                    String? dersad = dersadController.text.toUpperCase();
                    //DersModel dersModel = DersModel();
                    int? id = sonId;
                    //String dersAd = dersad;
                    int sinifId = -1;
                    widget.onClickedDone(id, dersad, sinifId);
                    Navigator.of(context).pop(); //todo: navigator pop return value
                  }
                }),
          ],
        ),
      ],
    );
  }

  // Widget buildSinif(BuildContext context, List<SinifModel> transactionsSinif) =>
  //     SizedBox(
  //       width: MediaQuery.of(context).size.width * .6,
  //       child: DropdownSearch<String>(
  //         mode: Mode.MENU,
  //         items: buildItems(),
  //         //label: "Sınıflar",
  //         //hint: "country in menu mode",
  //         onChanged: (value) {
  //           //print('seçilen $value');
  //           int sinifid = transactionsSinif
  //               .singleWhere((element) => element.sinifAd == value)
  //               .id;
  //           sinifStore.setSinifId(sinifid);
  //           //print('storedan glen id' + sinifStore.sinifId.toString());
  //         },
  //         selectedItem: sinifStore.sinifAd,
  //       ),
  //     );

  Widget builddersad() => TextFormField(
        controller: dersadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Ders Adını Giriniz',
        ),
        validator: (dersad) => dersad != null && dersad.isEmpty ? 'Ders Adını' : null,
      );

  // List<String> buildItems() {
  //   List<String> items = SinifBoxes.getTransactions()
  //       .values
  //       .map((e) => e.sinifAd.toString())
  //       .toList();
  //   return items;
  // }
}
