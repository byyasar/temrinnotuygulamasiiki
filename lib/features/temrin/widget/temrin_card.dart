import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/ders/model/ders_model.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';

class TemrinCard extends StatelessWidget {
  final TemrinModel transaction;
  final int index;
  final Widget butons;
  final List<DersModel>? dersList;

  const TemrinCard(
      {Key? key,
      required this.transaction,
      required this.index,
      required this.butons,
      this.dersList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          "${index + 1} - ${transaction.temrinKonusu}",
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
            "id: ${transaction.id.toString()} ders : ${dersAdiniGetir(transaction.dersId)}"),
        children: [butons],
      ),
    );
  }

  String? dersAdiniGetir(int? id) {
    if (dersList!.isNotEmpty) {
      return dersList!.firstWhere((element) => element.id == id).dersAd ?? "";
    }
  }
}
