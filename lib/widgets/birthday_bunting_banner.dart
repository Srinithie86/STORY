import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// Neat & Clean Festive Birthday Bunting Banner Overlay
/// Deep burgundy pennant flags on curved twine with white bold letters:
/// [ H A P P Y ] on top twine, [ B I R T H D A Y ] on bottom twine
/// Features gentle, natural ambient wind-swaying animation and soft paper shadows.
class BirthdayBuntingBanner extends StatefulWidget {
  final double? maxWidth;

  const BirthdayBuntingBanner({
    super.key,
    this.maxWidth,
  });

  @override
  State<BirthdayBuntingBanner> createState() => _BirthdayBuntingBannerState();
}

class _BirthdayBuntingBannerState extends State<BirthdayBuntingBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _swayController;
  late Animation<double> _swayAnimation;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _swayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    )..repeat(reverse: true);

    _swayAnimation = Tween<double>(begin: -0.015, end: 0.015).animate(
      CurvedAnimation(parent: _swayController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _swayController.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() => _isTapped = true);
    _swayController.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isTapped = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final targetWidth = widget.maxWidth ?? (isMobile ? 360.0 : 680.0);

    return GestureDetector(
      onTap: _onTap,
      child: Center(
        child: AnimatedBuilder(
          animation: _swayAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..rotateZ(_swayAnimation.value + (_isTapped ? 0.02 : 0.0)),
              child: child,
            );
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: targetWidth),
            margin: EdgeInsets.only(
              top: isMobile ? 8 : 16,
              bottom: isMobile ? 18 : 28,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Soft Ambient Depth Shadow
                Opacity(
                  opacity: 0.22,
                  child: Image.asset(
                    "assets/photos/birthday_bunting_banner.png",
                    width: targetWidth,
                    fit: BoxFit.contain,
                    color: Colors.black,
                  ),
                ),

                // Main High-Definition Transparent Burgundy Bunting Garland
                Image.asset(
                  "assets/photos/birthday_bunting_banner.png",
                  width: targetWidth,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
