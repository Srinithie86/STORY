import 'dart:math';
import 'package:flutter/material.dart';

/// Custom Painter for Sunflower Bloom Motif
class SunflowerMotifPainter extends CustomPainter {
  final Color centerColor;
  final Color petalColor;

  SunflowerMotifPainter({
    this.centerColor = const Color(0xFF3E2723), // Deep Cocoa Brown Center
    this.petalColor = const Color(0xFFFFB300),  // Sunflower Golden Yellow
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2.3;

    final petalPaint = Paint()
      ..color = petalColor
      ..style = PaintingStyle.fill;

    final petalStroke = Paint()
      ..color = const Color(0xFFE65100).withValues(alpha:  0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw 12 Sunflower Petals
    final numPetals = 12;
    for (int i = 0; i < numPetals; i++) {
      final angle = (i * 360 / numPetals) * pi / 180;
      final petalPath = Path();
      petalPath.moveTo(center.dx, center.dy);

      final tip = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final ctrl1 = Offset(
        center.dx + (radius * 0.65) * cos(angle - 0.22),
        center.dy + (radius * 0.65) * sin(angle - 0.22),
      );

      final ctrl2 = Offset(
        center.dx + (radius * 0.65) * cos(angle + 0.22),
        center.dy + (radius * 0.65) * sin(angle + 0.22),
      );

      petalPath.cubicTo(ctrl1.dx, ctrl1.dy, tip.dx, tip.dy, tip.dx, tip.dy);
      petalPath.cubicTo(ctrl2.dx, ctrl2.dy, center.dx, center.dy, center.dx, center.dy);

      canvas.drawPath(petalPath, petalPaint);
      canvas.drawPath(petalPath, petalStroke);
    }

    // Sunflower Center Disc
    final centerPaint = Paint()
      ..color = centerColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.38, centerPaint);

    // Seed Texture Dots inside Center
    final seedPaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha:  0.7)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 6; i++) {
      final dotAngle = (i * 60) * pi / 180;
      final dotPos = Offset(
        center.dx + (radius * 0.2) * cos(dotAngle),
        center.dy + (radius * 0.2) * sin(dotAngle),
      );
      canvas.drawCircle(dotPos, 1.2, seedPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Sunflower Badge with Romantic Text
class SunflowerBadge extends StatelessWidget {
  final String label;

  const SunflowerBadge({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFB300), // Vibrant Sunflower Yellow
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6B0F1A), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("🌻 ", style: TextStyle(fontSize: 12)),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: Color(0xFF6B0F1A), // Maroon Red
            ),
          ),
        ],
      ),
    );
  }
}
