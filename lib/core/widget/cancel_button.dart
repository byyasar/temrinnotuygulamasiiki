import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';

Widget buildCancelButton(BuildContext context) => myCustomMenuButton(
    context, () => Navigator.of(context).pop(), const Text('İptal'), IconsConstans.exitIcon, Colors.red);
