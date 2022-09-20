import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';

class DersCard extends StatelessWidget {
  final DersModel transaction;
  final int index;
  final Widget butons;

  const DersCard(
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
          "${index + 1} - ${transaction.dersAd}",
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
            "id: ${transaction.id.toString()} sinif : ${transaction.sinifId}"),
        children: [butons],
      ),
    );
  }
}
