import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/exitapp_dialog.dart';

AppBar customAppBar(
    {required BuildContext context, required Widget title, Widget? search}) {
  return AppBar(
    title: title,
    actions: [
      search ?? const SizedBox(),
      IconButton(
        onPressed: () {
          exitAppDialog(context);
        },
        icon: IconsConstans.exitIcon,
      )
    ],
  );
}
