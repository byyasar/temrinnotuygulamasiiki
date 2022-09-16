import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';

Future<bool> exitAppDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Eminmisiniz?'),
      content: const Text('Uygulama kapatılsın mı?'),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        myCustomMenuButton(context, () {
          SystemNavigator.pop();
          exit(0);
        }, const Text('Kapat'), const Icon(Icons.check_box_rounded), Colors.red),
        const SizedBox(width: 10),
        myCustomMenuButton(context, () {
          Navigator.of(context).pop(false);
        }, const Text('İptal'), const Icon(Icons.cancel), Colors.blue),
      ],
    ),
  );
}
