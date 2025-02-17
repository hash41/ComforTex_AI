import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const TopBar(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 16.0, 0),
          child: Image.asset('icons/4.png'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
