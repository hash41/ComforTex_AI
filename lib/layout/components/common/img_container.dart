import 'package:flutter/material.dart';

/// A decoratedContainer to make the identification easier of selectedImage from
/// [polo,tShirt].
class ImgContainer extends StatelessWidget {
  ///Constructor for the ImgContainer.
  const ImgContainer({required Widget child, super.key, bool selected = false})
      : _child = child,
        _selected = selected;

  final bool _selected;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(4),
      duration: const Duration(milliseconds: 450),
      decoration: BoxDecoration(
        border:
        _selected ? Border.all(width: 8, color: Colors.lightBlue) : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: _child,
    );
  }
}