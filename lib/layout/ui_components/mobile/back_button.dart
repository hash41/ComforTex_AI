import 'package:flutter/material.dart';


/// A button in the appbar to pop the current context (return to the previous
/// screen)
class MaterialBackButton extends StatelessWidget {
  /// Default constructor..
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
