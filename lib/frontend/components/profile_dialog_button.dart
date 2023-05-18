import 'package:flutter/material.dart';

class ProfileDialogButton extends StatelessWidget {
  late final Widget dialogWidget;
  late final String text;
  late final Icon icon;

  ProfileDialogButton(
      {super.key,
      required this.dialogWidget,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (BuildContext context) => dialogWidget);
      },
      child: Column(
        children: [
          ListTile(
            leading: icon,
            title: Text(text),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
