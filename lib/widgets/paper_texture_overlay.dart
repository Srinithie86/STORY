import 'dart:math';
import 'package:flutter/material.dart';

class PaperTextureOverlay extends StatelessWidget {
  final Widget child;

  const PaperTextureOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _SubtlePaperTexturePainter(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubtlePaperTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6B0F1A).withValues(alpha: 0.012)
      ..strokeWidth = 1.0;

    // Subtle paper grain dots
    final random = Random(42);
    for (int i = 0; i < 90; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 0.7 + 0.3;
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
