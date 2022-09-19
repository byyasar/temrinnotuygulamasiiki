import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/widget/add_button.dart';
import 'package:temrinnotuygulamasiiki/core/widget/cancel_button.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';

class SinifDialog extends StatefulWidget {
  final SinifModel? transaction;

  final Function(int? id, String sinifAd) onClickedDone;

  const SinifDialog({
    Key? key,
    this.transaction,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _SinifDialogState createState() => _SinifDialogState();
}

class _SinifDialogState extends State<SinifDialog> {
  final formKey = GlobalKey<FormState>();
  final sinifadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.transaction != null) {
      final transaction = widget.transaction!;
      sinifadController.text = transaction.sinifAd ?? "";
    }
  }

  @override
  void dispose() {
    sinifadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.transaction != null;
    final title = isEditing ? 'Sınıfı Düzenle' : 'Sınıf Ekle';
    int? sonId;
    isEditing ? sonId = widget.transaction!.id : 0;
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildSinifad(),
              const SizedBox(height: 8),
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
                  String? sinifAd = sinifadController.text.toUpperCase();
                  // int? nu = int.parse(nuController.text);
                  widget.onClickedDone(sonId, sinifAd);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSinifad() => TextFormField(
        controller: sinifadController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Sınıf Adını Giriniz',
        ),
        validator: (sinifAd) => sinifAd != null && sinifAd.isEmpty ? 'Sınıf Adını Yazınız' : null,
      );
}
