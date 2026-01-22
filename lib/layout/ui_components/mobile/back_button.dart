import 'package:flutter/material.dart';

class MaterialBackButton extends StatelessWidget {
  const MaterialBackButton({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      elevation: 0,
      height: 32,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back),
    );
  }
}