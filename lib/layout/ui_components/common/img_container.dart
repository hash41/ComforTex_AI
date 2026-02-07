import 'package:flutter/material.dart';

/// A decoratedContainer to make the identification easier of selectedImage from
/// [polo,tShirt].
class ImgContainer extends StatelessWidget {
  ///Constructor for the ImgContainer.
  const ImgContainer({
    required Widget child,
    super.key,
    bool selected = false,
    GestureTapCallback? onTap,
  })  : _child = child,
        _selected = selected,
        _onTap = onTap;

  final bool _selected;
  final Widget _child;
  final GestureTapCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      hoverColor: Colors.lightGreen,
      hoverDuration: const Duration(milliseconds: 350),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedContainer(
            padding: const EdgeInsets.all(5),
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
              border: _selected
                  ? Border.all(width: 3, color: Colors.lightBlue)
                  : null,
              borderRadius: BorderRadius.circular(2),
            ),
            child: _child,
          ),
          if (_selected)
            const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 32,
              ),
            ),
        ],
      ),
    );
  }
}
