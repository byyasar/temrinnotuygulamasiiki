import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';

Future<bool> customDialogFunc(
    BuildContext context, String title, String content, String okText, String cancelText) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              myCustomMenuButton(context, () {
                Navigator.of(context).pop(true);
              }, Text(okText), const Icon(Icons.check_box_rounded), Colors.red),
              const SizedBox(width: 10),
              myCustomMenuButton(context, () {
                Navigator.of(context).pop(false);
              }, Text(cancelText), const Icon(Icons.cancel), Colors.green),
            ],
          ));
}

Future<bool> customDialogInfo(BuildContext context, String title, String content, String okText) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              myCustomMenuButton(context, () {
                Navigator.of(context).pop(false);
              }, Text(okText), const Icon(Icons.check_box_rounded), Colors.green),
            ],
          ));
}
