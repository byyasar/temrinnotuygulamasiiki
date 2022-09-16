import 'package:flutter/material.dart';


Widget myCustomMenuButton(
    BuildContext context, VoidCallback? voidCallback, Widget btnText, Icon btnIcon, Color? btnPrimary) {
  //final text = btnText.cast<Text>;
  btnPrimary ?? Colors.blue;

  return ElevatedButton(
    style: ElevatedButton.styleFrom(primary: btnPrimary, textStyle: const TextStyle(fontSize: 18)),
    onPressed: voidCallback,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [btnIcon, const SizedBox(width: 10), btnText],
    ),
  );
}

