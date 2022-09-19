import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/exitapp_dialog.dart';

AppBar customAppBar(BuildContext context, Widget title) {
  return AppBar(
    title: title,
    actions: [
      IconButton(
        onPressed: () {
          exitAppDialog(context);
        },
        icon: IconsConstans.exitIcon,
      )
    ],
  );
}
