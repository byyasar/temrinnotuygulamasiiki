import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/ogrenci/model/ogrenci_model.dart';

class OgrenciCard extends StatelessWidget {
  final OgrenciModel transaction;
  final int index;
  final Widget butons;

  const OgrenciCard(
      {Key? key,
      required this.transaction,
      required this.index,
      required this.butons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white60,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          "${index + 1} - ${transaction.ogrenciAdSoyad}",
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
            "id: ${transaction.id.toString()} ogrenci nu: ${transaction.ogrenciNu.toString()} sınıf id:${transaction.sinifId.toString()} "),
        children: [butons],
      ),
    );
  }
}
