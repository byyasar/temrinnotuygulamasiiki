import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';

Widget buildOkButton(BuildContext context, VoidCallback onPressed) =>
    myCustomMenuButton(context, onPressed, const Text('Tamam'), IconsConstans.okIcon, Colors.green);
