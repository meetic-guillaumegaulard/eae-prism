import 'package:flutter/material.dart';
import '../../templates/screen_layout/screen_layout_eae.dart';

/// Widget pour animer toute la page (utilisé quand animateFullPage = true)
class FullPageTransition extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;
  final TransitionDirection direction;
  final Widget child;

  const FullPageTransition({
    super.key,
    required this.animation,
    required this.secondaryAnimation,
    required this.direction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Offset de départ selon la direction
    final Offset beginOffset = switch (direction) {
      TransitionDirection.left => const Offset(1.0, 0.0),
      TransitionDirection.right => const Offset(-1.0, 0.0),
      TransitionDirection.up => const Offset(0.0, 1.0),
      TransitionDirection.down => const Offset(0.0, -1.0),
    };

    final offsetAnimation = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    ));

    // Animation de sortie de l'écran précédent
    final exitOffset = switch (direction) {
      TransitionDirection.left => const Offset(-0.3, 0.0),
      TransitionDirection.right => const Offset(0.3, 0.0),
      TransitionDirection.up => const Offset(0.0, -0.3),
      TransitionDirection.down => const Offset(0.0, 0.3),
    };

    final secondaryOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: exitOffset,
    ).animate(CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeOutCubic,
    ));

    return SlideTransition(
      position: secondaryOffsetAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    );
  }
}

