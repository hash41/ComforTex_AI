import 'package:flutter/material.dart';


///The top part of the screen refactored here to implement in different sizes
///among desktop and mobile screens.
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  ///Constructor for the TopBar.
  const TopBar(this._height, {super.key});
  final double _height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _height,
      backgroundColor: Colors.grey[100],
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: Image.asset('assets/icons/logo.png'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_height);
}
