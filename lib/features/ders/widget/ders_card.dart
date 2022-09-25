// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';

class DersCard extends StatelessWidget {
  final DersModel transaction;
  final int index;
  final Widget butons;
  final List<SinifModel>? sinifList;

  const DersCard({
    Key? key,
    required this.transaction,
    required this.index,
    required this.butons,
    this.sinifList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          "${index + 1} - ${transaction.dersAd}",
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("id: ${transaction.id.toString()} sinif : ${sinifAdiniGetir(transaction.sinifId)}"),
        children: [butons],
      ),
    );
  }

  String? sinifAdiniGetir(int? id) {
    if (sinifList!.isNotEmpty) {
      return sinifList!.firstWhere((element) => element.id == id).sinifAd ?? "";
    }
  }
}
