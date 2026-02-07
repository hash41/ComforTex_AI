import 'package:comfortex_ai/layout/screens/select_ai_screen.dart';
import 'package:flutter/material.dart';

/// Options widget allow the user to select another AI version
class Options extends StatelessWidget {
  /// DEFAULT CONSTRUCTOR
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(
        Icons.settings,
        size: 28,
        fontWeight: FontWeight.w100,
      ),
      onTap: () {
        if(context.mounted) {
          Navigator.of(context).push(
              PageRouteBuilder<SelectAiScreen>(
                transitionDuration: const Duration(
                  seconds: 2,
                ),
                reverseTransitionDuration: const Duration(
                  seconds: 2,
                ),
                pageBuilder: (_, __, ___) => SelectAiScreen(),
                transitionsBuilder: (context, animation1, animation2, child) {
                  final curved =
                  CurvedAnimation(parent: animation1, curve: Curves.decelerate);
                  return ScaleTransition(
                    scale: curved,
                    child: child,
                  );
                },
              ),
          );
        }
      },
    );
  }
}
