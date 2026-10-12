import 'dart:math';
import 'package:flutter/material.dart';

/// South Indian Traditional Kolam Motif Painter
class KolamMotifPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  KolamMotifPainter({
    this.color = const Color(0xFFD4AF37), // Zari Gold
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2.4;

    // Draw central lotus flower petals (8-petal symmetric Kolam)
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * pi / 180;
      final petalPath = Path();
      petalPath.moveTo(center.dx, center.dy);
      
      final ctrl1 = Offset(
        center.dx + (radius * 0.7) * cos(angle - 0.25),
        center.dy + (radius * 0.7) * sin(angle - 0.25),
      );
      final tip = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      final ctrl2 = Offset(
        center.dx + (radius * 0.7) * cos(angle + 0.25),
        center.dy + (radius * 0.7) * sin(angle + 0.25),
      );

      petalPath.cubicTo(ctrl1.dx, ctrl1.dy, tip.dx, tip.dy, tip.dx, tip.dy);
      petalPath.cubicTo(ctrl2.dx, ctrl2.dy, center.dx, center.dy, center.dx, center.dy);

      canvas.drawPath(petalPath, paint);
    }

    // Outer Kolam Dots (Pulli Kolam dots)
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45 + 22.5) * pi / 180;
      final dotPos = Offset(
        center.dx + (radius * 1.15) * cos(angle),
        center.dy + (radius * 1.15) * sin(angle),
      );
      canvas.drawCircle(dotPos, 2.0, dotPaint);
    }

    // Concentric Inner Gold Circle
    canvas.drawCircle(center, radius * 0.35, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Zari Gold Border Container with South Indian Silk Saree Border Detail
class ZariBorderContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color zariColor;
  final double borderRadius;

  const ZariBorderContainer({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor = const Color(0xFFFDFBF7),
    this.zariColor = const Color(0xFFD4AF37),
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: zariColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B0F1A).withValues(alpha:  0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Inner Thin Zari Frame Line
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(max(2, borderRadius - 4)),
                  border: Border.all(
                    color: zariColor.withValues(alpha:  0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),

          // Top Left Kolam Corner Accent
          Positioned(
            top: -4,
            left: -4,
            child: CustomPaint(
              size: const Size(24, 24),
              painter: KolamMotifPainter(color: zariColor.withValues(alpha:  0.7)),
            ),
          ),

          // Top Right Kolam Corner Accent
          Positioned(
            top: -4,
            right: -4,
            child: CustomPaint(
              size: const Size(24, 24),
              painter: KolamMotifPainter(color: zariColor.withValues(alpha:  0.7)),
            ),
          ),

          child,
        ],
      ),
    );
  }
}

/// South Indian Traditional Floral Badge (Jasmine / Marigold)
class JasmineFlowerBadge extends StatelessWidget {
  final String text;
  final IconData? icon;

  const JasmineFlowerBadge({
    super.key,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD54F), Color(0xFFFFB300)],
        ),
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
          const Text("🌼 ", style: TextStyle(fontSize: 12)),
          Text(
            text.toUpperCase(),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: Color(0xFF6B0F1A), // Kumkum Maroon
            ),
          ),
          if (icon != null) ...[
            const SizedBox(width: 4),
            Icon(icon, size: 12, color: const Color(0xFF6B0F1A)),
          ],
        ],
      ),
    );
  }
}
