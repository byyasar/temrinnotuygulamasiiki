import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_cubit.dart';
import 'package:temrinnotuygulamasiiki/features/ders/cubit/ders_state.dart';
import 'package:temrinnotuygulamasiiki/features/ders/service/ders_database_provider.dart';
import 'package:temrinnotuygulamasiiki/features/temrin/model/temrin_model.dart';

class TemrinCard extends StatelessWidget {
  final TemrinModel transaction;
  final int index;
  final Widget butons;

  const TemrinCard(
      {Key? key,
      required this.transaction,
      required this.index,
      required this.butons})
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
            "id: ${transaction.id.toString()} ders : ${transaction.dersId}"),
        children: [butons],
      ),
    );
  }
}
