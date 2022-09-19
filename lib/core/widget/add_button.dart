import 'package:flutter/material.dart';
import 'package:temrinnotuygulamasiiki/constans/icon_constans.dart';
import 'package:temrinnotuygulamasiiki/core/widget/custom_menu_button.dart';

class BuildAddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final BuildContext context;
  final int? sonId;
  final bool isEditing;

  const BuildAddButton({
    Key? key,
    required this.context,
    required this.onPressed,
    required this.sonId,
    required this.isEditing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = isEditing ? 'Kaydet' : 'Ekle';
    return myCustomMenuButton(context, onPressed, Text(text), IconsConstans.addIcon, Colors.green);
    /* TextButton(
      child: Row(
        children: [
          Icon(Icons.add_box, color: Colors.blue.shade400),
          Text(text, style: const TextStyle(fontSize: 18.0)),
        ],
      ),
      onPressed: onPressed,
    ); */
  }
}
