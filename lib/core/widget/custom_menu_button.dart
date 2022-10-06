import 'package:flutter/material.dart';

Widget myCustomMenuButton(BuildContext context, VoidCallback? voidCallback,
    Widget btnText, Icon btnIcon, Color? btnPrimary) {
  //final text = btnText.cast<Text>;
  btnPrimary ?? Colors.blue;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, textStyle: const TextStyle(fontSize: 16)),
    onPressed: voidCallback,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [btnIcon, const SizedBox(width: 2), btnText],
    ),
  );
}
