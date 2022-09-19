import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/features/sinif/model/sinif_model.dart';

class SinifCard extends StatelessWidget {
  final SinifModel transaction;
  final int index;
  final Widget butons;

  const SinifCard({Key? key, required this.transaction, required this.index, required this.butons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white60,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          "${index + 1} - ${transaction.sinifAd}",
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text("id: ${transaction.id.toString()} "),
        children: [butons],
      ),
    );
  }
}
