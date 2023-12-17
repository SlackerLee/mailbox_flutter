import 'package:flutter/material.dart';

class HomeComposeFAB extends StatelessWidget {
  final bool isScrolledUp;
  final VoidCallback onPressed;

  const HomeComposeFAB(
      {super.key, required this.isScrolledUp, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: onPressed,
        label: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          ),
          child: isScrolledUp
              ? const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Icon(Icons.edit),
                    ),
                    Text("Compose")
                  ],
                )
              : const Icon(Icons.arrow_forward),
        ));
  }
}
