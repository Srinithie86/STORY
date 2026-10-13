import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'photo_viewer.dart';
import 'boyfriend_birthday_calendar_hero.dart';

class ForeverArchiveSection extends StatefulWidget {
  const ForeverArchiveSection({super.key});

  @override
  State<ForeverArchiveSection> createState() => _ForeverArchiveSectionState();
}

class _ForeverArchiveSectionState extends State<ForeverArchiveSection> {
  int? _expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final archives = StoryConfig.yearlyArchives;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.contentWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FOREVER ARCHIVE",
                style: AppTheme.monoStyle(
                  fontSize: 11,
                  letterSpacing: 2.5,
                  color: AppTheme.deepBurgundy,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Years yet to come, memories to be written.",
                style: AppTheme.serifStyle(
                  fontSize: isMobile ? 28 : 40,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              const SizedBox(height: 36),

              // Expandable Yearly Cards
              Column(
                children: List.generate(archives.length, (index) {
                  final archive = archives[index];
                  final isExpanded = _expandedIndex == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: AppTheme.warmPaper,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isExpanded
                            ? AppTheme.deepBurgundy
                            : AppTheme.warmTaupe,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Card Header
                        InkWell(
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? null : index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        archive.year,
                                        style: AppTheme.monoStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.deepBurgundy,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          archive.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTheme.serifStyle(
                                            fontSize: isMobile ? 20 : 24,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.darkCharcoal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: AppTheme.darkCharcoal,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Expanded Content Body
                        if (isExpanded) ...[
                          const Divider(height: 1, color: AppTheme.warmTaupe),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  archive.description,
                                  style: AppTheme.serifStyle(
                                    fontSize: 18,
                                    color: AppTheme.darkCharcoal,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "“${archive.letter}”",
                                  style: AppTheme.handwrittenStyle(
                                    fontSize: 20,
                                    color: AppTheme.mutedRose,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${archive.memories.length} MEMORIES SAVED",
                                        style: AppTheme.monoStyle(
                                          fontSize: 10,
                                          color: AppTheme.mutedGray,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      TextButton(
                                        onPressed: () {
                                          PhotoViewerDialog.show(
                                              context, archive.memories, 0);
                                        },
                                        child: Text(
                                          "VIEW YEAR ALBUM →",
                                          style: AppTheme.monoStyle(
                                            fontSize: 11,
                                            color: AppTheme.deepBurgundy,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 60),

              // 3D Cake Cutting & Candle Blowing Widget 🎂🔪
              const InteractiveCakeCuttingWidget(),
              const SizedBox(height: 60),

              // Boyfriend Birthday Calendar Poster Card (OCTOBER 10) 🗓️
              const BoyfriendBirthdayCalendarHero(),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// REAL VINTAGE 3D INTERACTIVE CAKE CUTTING WIDGET 🎂🔪
// =========================================================

class InteractiveCakeCuttingWidget extends StatefulWidget {
  const InteractiveCakeCuttingWidget({super.key});

  @override
  State<InteractiveCakeCuttingWidget> createState() =>
      _InteractiveCakeCuttingWidgetState();
}

class _InteractiveCakeCuttingWidgetState
    extends State<InteractiveCakeCuttingWidget>
    with TickerProviderStateMixin {
  bool _isCut = false;
  bool _candlesBlown = false;

  late AnimationController _sliceController;
  late Animation<double> _sliceAnimation;
  late AnimationController _extinguishController;
  late Animation<double> _extinguishAnimation;
  late AnimationController _flickerController;
  late AnimationController _knifeHoverController;

  final List<_CakeConfettiParticle> _confetti = [];
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();

    _sliceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _sliceAnimation = CurvedAnimation(
      parent: _sliceController,
      curve: Curves.easeOutBack,
    );

    _extinguishController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _extinguishAnimation = CurvedAnimation(
      parent: _extinguishController,
      curve: Curves.easeOut,
    );

    _flickerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _knifeHoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _sliceController.dispose();
    _extinguishController.dispose();
    _flickerController.dispose();
    _knifeHoverController.dispose();
    super.dispose();
  }

  void _spawnConfetti() {
    setState(() {
      for (int i = 0; i < 18; i++) {
        _confetti.add(_CakeConfettiParticle(
          x: 100 + _rnd.nextDouble() * 150,
          y: 80 + _rnd.nextDouble() * 80,
          vx: (_rnd.nextDouble() - 0.5) * 5.0,
          vy: -3.0 - _rnd.nextDouble() * 4.0,
          emoji: ["🎉", "✨", "🍰", "💖", "🍓", "🌸"][i % 6],
          size: 14 + _rnd.nextDouble() * 10,
        ));
      }
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _confetti.clear();
        });
      }
    });
  }

  void _blowCandles() {
    if (_sliceController.isAnimating) return;
    setState(() {
      _candlesBlown = !_candlesBlown;
    });
    if (_candlesBlown) {
      _extinguishController.forward();
      _spawnConfetti();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Candles blown out with love! 🕯️✨ Make a secret wish ♡",
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF722F37),
          duration: const Duration(milliseconds: 1800),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      );
    } else {
      _extinguishController.reverse();
    }
  }

  void _cutCake() {
    if (_sliceController.isAnimating) return;
    if (_isCut) {
      _resetCake();
      return;
    }
    setState(() {
      _isCut = true;
    });
    _spawnConfetti();
    _sliceController.forward();
  }

  void _resetCake() {
    if (_sliceController.isAnimating) return;
    _sliceController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _isCut = false;
        });
      }
    });
  }

  String get _instructionText {
    if (_isCut) {
      return "🍰 Ceremonial slice cut! Replay slice or read birthday message below ♡";
    } else if (_candlesBlown) {
      return "🕯️ Wish made! Tap the cake (or cut button) to cut the ceremonial first slice 🔪";
    } else {
      return "✨ Step 1: Tap candles (or blow button) to blow out flames & make a wish! 🕯️";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: Listenable.merge([
        _sliceAnimation,
        _extinguishAnimation,
        _flickerController,
        _knifeHoverController,
      ]),
      builder: (context, child) {
        final candleFlameGlow = (1.0 - _extinguishAnimation.value) * (0.08 + _flickerController.value * 0.04);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 24 : 36,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9F1), // Soft boutique cream warm ivory
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFFE8DDD2), // Delicate warm biscuit border
              width: 1.5,
            ),
            boxShadow: [
              // Ambient warm shadow
              BoxShadow(
                color: const Color(0xFF3D271D).withValues(alpha: 0.08),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
              // Golden candlelight ambient reflection
              BoxShadow(
                color: const Color(0xFFFFD54F).withValues(alpha: candleFlameGlow),
                blurRadius: 36,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              // 1. Header Pill Badge
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4EE),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE4C3AB),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome, size: 13, color: Color(0xFFB69A68)),
                      const SizedBox(width: 6),
                      Text(
                        "VINTAGE 3D BIRTHDAY CAKE · CELEBRATING 24 YEARS",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: isMobile ? 9 : 10.5,
                          letterSpacing: 1.4,
                          color: const Color(0xFF722F37),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.auto_awesome, size: 13, color: Color(0xFFB69A68)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "“Make a Wish & Cut the First Slice”",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: isMobile ? 26 : 34,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF282522),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              // Instruction Hint Pill
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF2EB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE4C3AB),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    _instructionText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 10 : 12,
                      color: const Color(0xFF722F37),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // 2. 3D Isometric Vintage Lambeth Cake Viewport
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!_candlesBlown) {
                          _blowCandles();
                        } else {
                          _cutCake();
                        }
                      },
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomPaint(
                          size: Size(isMobile ? 260 : 360, isMobile ? 210 : 270),
                          painter: _Real3DCakePainter(
                            sliceProgress: _sliceAnimation.value,
                            isCut: _isCut,
                            candlesBlown: _candlesBlown,
                            extinguishProgress: _extinguishAnimation.value,
                            flickerProgress: _flickerController.value,
                            knifeHover: _knifeHoverController.value,
                          ),
                        ),
                      ),
                    ),

                    // Floating celebration confetti on cut
                    ..._confetti.map((p) {
                      return Positioned(
                        left: p.x,
                        top: p.y,
                        child: Text(
                          p.emoji,
                          style: TextStyle(fontSize: p.size),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Action Buttons: Blow Candles & Cut Cake
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  // Blow / Relight Candles Button
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: OutlinedButton.icon(
                      onPressed: _blowCandles,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: _candlesBlown ? const Color(0xFFB69A68) : const Color(0xFFD48B5E),
                          width: 1.4,
                        ),
                        backgroundColor: const Color(0xFFFFF4EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 14 : 22,
                          vertical: isMobile ? 10 : 13,
                        ),
                      ),
                      icon: Text(_candlesBlown ? "✨" : "🕯️", style: const TextStyle(fontSize: 16)),
                      label: Text(
                        _candlesBlown ? "RELIGHT CANDLES 🔥" : "BLOW CANDLES 💨",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: isMobile ? 10 : 11.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: const Color(0xFF722F37),
                        ),
                      ),
                    ),
                  ),

                  // Cut / Replay Cake Button
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ElevatedButton.icon(
                      onPressed: _cutCake,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF722F37), // Muted burgundy
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: const Color(0xFF722F37).withValues(alpha: 0.30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(color: Color(0xFFE2C89A), width: 1.2),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 26,
                          vertical: isMobile ? 11 : 14,
                        ),
                      ),
                      icon: Text(_isCut ? "🍰" : "🔪", style: const TextStyle(fontSize: 17)),
                      label: Text(
                        _isCut ? "REPLAY SLICE 🍰" : "CUT FIRST SLICE 🎂",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: isMobile ? 10.5 : 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 4. In-Place Non-Covering Birthday Celebration Card
              AnimatedSize(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeOutCubic,
                child: _isCut
                    ? Container(
                        margin: const EdgeInsets.only(top: 24),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 18 : 28,
                          vertical: isMobile ? 20 : 26,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCFAF6), // Clean warm ivory
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFB69A68),
                            width: 1.4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF722F37).withValues(alpha: 0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text("🎉 🎂 🎉", style: TextStyle(fontSize: 28)),
                            const SizedBox(height: 8),
                            Text(
                              "HAPPY BIRTHDAY, MY SOULMATE!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cinzel(
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.8,
                                color: const Color(0xFF722F37),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "You cut the ceremonial first slice of our 2026 Birthday Cake! 🍰",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.caveat(
                                fontSize: isMobile ? 18 : 22,
                                color: const Color(0xFF4A3228),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "“May every year we celebrate together be even sweeter than the last. You are my greatest joy, my best friend, and the love of my entire life.”",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: isMobile ? 16 : 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF282522),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: _resetCake,
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFF722F37), width: 1.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                  ),
                                  child: Text(
                                    "CUT AGAIN 🔪",
                                    style: AppTheme.monoStyle(
                                      fontSize: 11,
                                      color: const Color(0xFF722F37),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    _blowCandles();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF722F37),
                                    foregroundColor: Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                  ),
                                  child: Text(
                                    _candlesBlown ? "RELIGHT CANDLES 🔥" : "MAKE ANOTHER WISH ✨",
                                    style: AppTheme.monoStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Floating confetti particle for cake slice burst
class _CakeConfettiParticle {
  double x;
  double y;
  double vx;
  double vy;
  String emoji;
  double size;

  _CakeConfettiParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.emoji,
    required this.size,
  });
}

/// High-End Pinterest Vintage Lambeth 3D Layer Cake Painter
/// Features:
/// - 3D Fluted French Porcelain Stand with Gold Filigree Rim
/// - Dual-layer vintage Lambeth piping, scallops, and delicate draped garland swags
/// - Flickering birthday candle flames (or gentle smoke curls when blown out)
/// - Red Velvet interior with rich cream-cheese frosting and ruby strawberry lines
/// - Vintage engraved silver cake knife with pink satin ribbon bow
class _Real3DCakePainter extends CustomPainter {
  final double sliceProgress;
  final bool isCut;
  final bool candlesBlown;
  final double extinguishProgress;
  final double flickerProgress;
  final double knifeHover;

  _Real3DCakePainter({
    required this.sliceProgress,
    required this.isCut,
    required this.candlesBlown,
    required this.extinguishProgress,
    required this.flickerProgress,
    required this.knifeHover,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h * 0.68;

    // 1. Shaded Drop Shadow onto table
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, cy + 34),
        width: w * 0.86,
        height: h * 0.28,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.12),
    );

    // 2. 3D French Porcelain Pedestal Cake Stand with Champagne Gold Rim
    // Fluted Foot
    final footPath = Path();
    footPath.moveTo(cx - w * 0.16, cy + 34);
    footPath.quadraticBezierTo(cx, cy + 26, cx + w * 0.16, cy + 34);
    footPath.lineTo(cx + w * 0.08, cy + 20);
    footPath.lineTo(cx - w * 0.08, cy + 20);
    footPath.close();

    canvas.drawPath(
      footPath,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFE0D8CB), Color(0xFFFFFDF9), Color(0xFFD4C8B5)],
        ).createShader(Rect.fromLTWH(cx - w * 0.16, cy + 20, w * 0.32, 14)),
    );

    // Porcelain Plate Base
    final plateRect = Rect.fromCenter(
      center: Offset(cx, cy + 20),
      width: w * 0.82,
      height: h * 0.25,
    );

    // Gold Rim
    canvas.drawOval(
      plateRect,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFD4AF37), Color(0xFFFFF4D0), Color(0xFFC59B27)],
        ).createShader(plateRect),
    );

    // Porcelain Plate Surface
    final innerPlateRect = Rect.fromCenter(
      center: Offset(cx, cy + 18),
      width: w * 0.78,
      height: h * 0.22,
    );
    canvas.drawOval(
      innerPlateRect,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFFFFDF9), Color(0xFFF3ECE0), Color(0xFFFFFDF9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(innerPlateRect),
    );

    // 3. 3D Cake Cylinder Dimensions
    final cakeRadiusX = w * 0.32;
    final cakeRadiusY = h * 0.145;
    final cakeHeight = h * 0.34;

    // Cake Side Wall
    final wallRect = Rect.fromLTRB(
      cx - cakeRadiusX,
      cy - cakeHeight,
      cx + cakeRadiusX,
      cy,
    );

    // Vintage Pastel Buttercream Wall Gradient
    final wallGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFF3E7DC), // Ambient left shadow
        Color(0xFFFFFDF9), // Specular highlight front
        Color(0xFFF8EFE6), // Soft right shadow
      ],
      stops: [0.0, 0.48, 1.0],
    ).createShader(wallRect);

    // Draw Cylinder Body
    canvas.drawRect(wallRect, Paint()..shader = wallGradient);

    final bottomOvalRect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: cakeRadiusX * 2,
      height: cakeRadiusY * 2,
    );
    canvas.drawOval(bottomOvalRect, Paint()..shader = wallGradient);

    // Outline
    final lineOutline = Paint()
      ..color = const Color(0xFF5A2A35).withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    canvas.drawOval(bottomOvalRect, lineOutline);
    canvas.drawLine(
        Offset(cx - cakeRadiusX, cy - cakeHeight), Offset(cx - cakeRadiusX, cy), lineOutline);
    canvas.drawLine(
        Offset(cx + cakeRadiusX, cy - cakeHeight), Offset(cx + cakeRadiusX, cy), lineOutline);

    // 4. Vintage Lambeth Swag Garlands around the front side
    final garlandPaint = Paint()
      ..color = const Color(0xFFFFC0CB).withValues(alpha: 0.85) // Romantic Soft Rose Cream
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()..color = const Color(0xFFFF80AB);

    const int swagCount = 5;
    for (int i = 0; i < swagCount; i++) {
      final t1 = (i / swagCount) * pi;
      final t2 = ((i + 1) / swagCount) * pi;

      final p1x = cx + cakeRadiusX * cos(pi - t1);
      final p1y = (cy - cakeHeight * 0.45) + cakeRadiusY * sin(pi - t1);
      final p2x = cx + cakeRadiusX * cos(pi - t2);
      final p2y = (cy - cakeHeight * 0.45) + cakeRadiusY * sin(pi - t2);

      final midX = (p1x + p2x) / 2;
      final midY = ((p1y + p2y) / 2) + 14;

      final swagPath = Path();
      swagPath.moveTo(p1x, p1y);
      swagPath.quadraticBezierTo(midX, midY, p2x, p2y);
      canvas.drawPath(swagPath, garlandPaint);

      // Pearl drop at lowest point
      canvas.drawCircle(Offset(midX, midY), 2.2, dotPaint);
    }

    // 5. Cake Top Surface Oval
    final topOvalRect = Rect.fromCenter(
      center: Offset(cx, cy - cakeHeight),
      width: cakeRadiusX * 2,
      height: cakeRadiusY * 2,
    );

    final topFrosting = Paint()
      ..shader = const RadialGradient(
        center: Alignment(0.0, -0.2),
        radius: 0.85,
        colors: [Color(0xFFFFFDF9), Color(0xFFF9EFE4)],
      ).createShader(topOvalRect);

    canvas.drawOval(topOvalRect, topFrosting);
    canvas.drawOval(topOvalRect, lineOutline);

    // 6. Vintage Coquette Piped Shell Pearls around Top Rim 🌸
    final shellPearlPaint = Paint()..color = const Color(0xFFFFF0F5); // Lavender Blush Cream
    final pearlOutline = Paint()
      ..color = const Color(0xFF8B1220).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (int i = 0; i < 22; i++) {
      final angle = (i * 16.36) * pi / 180;
      final px = cx + (cakeRadiusX - 1) * cos(angle);
      final py = (cy - cakeHeight) + (cakeRadiusY - 1) * sin(angle);
      canvas.drawCircle(Offset(px, py), 4.6, shellPearlPaint);
      canvas.drawCircle(Offset(px, py), 4.6, pearlOutline);
    }

    // 7. Top Toppings: 3D Glossy Cherries 🍒 & Gold Leaf Flecks ✨
    final cherryPaint = Paint()..color = const Color(0xFFC2185B);
    final cherryShine = Paint()..color = Colors.white.withValues(alpha: 0.85);
    final goldLeafPaint = Paint()..color = const Color(0xFFD4AF37);
    final stemPaint = Paint()
      ..color = const Color(0xFF558B2F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 + 15) * pi / 180;
      final rx = cx + (cakeRadiusX * 0.60) * cos(angle);
      final ry = (cy - cakeHeight) + (cakeRadiusY * 0.60) * sin(angle);

      // Stem
      final stemPath = Path();
      stemPath.moveTo(rx, ry - 4);
      stemPath.quadraticBezierTo(rx + 6, ry - 14, rx + 10, ry - 12);
      canvas.drawPath(stemPath, stemPaint);

      // Cherry Body
      canvas.drawCircle(Offset(rx, ry), 7.0, cherryPaint);
      canvas.drawCircle(Offset(rx - 2.2, ry - 2.2), 2.2, cherryShine);
      canvas.drawCircle(Offset(rx, ry), 7.0, lineOutline);

      // Gold Sparkle fleck
      canvas.drawCircle(Offset(rx + 5, ry + 4), 1.8, goldLeafPaint);
    }

    // Center Message Piped on Top: "Mani ♡"
    final textPainter = TextPainter(
      text: TextSpan(
        text: "Mani ♡",
        style: GoogleFonts.greatVibes(
          fontSize: 18,
          color: const Color(0xFF8B1220),
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(cx - textPainter.width / 2, (cy - cakeHeight) - textPainter.height / 2),
    );

    // 8. Birthday Candles & Flickering Flames 🔥
    for (int i = 0; i < 3; i++) {
      final candX = cx + (i - 1) * 28;
      final candY = cy - cakeHeight - 10;

      // Candle Stick with Spiral Stripes
      final candleRect = Rect.fromLTWH(candX - 3.5, candY - 26, 7, 26);
      canvas.drawRRect(
        RRect.fromRectAndRadius(candleRect, const Radius.circular(2)),
        Paint()..color = const Color(0xFFFFF8E7),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(candleRect, const Radius.circular(2)),
        lineOutline,
      );

      // Gold diagonal stripe on candle
      canvas.drawLine(
        Offset(candX - 3.5, candY - 18),
        Offset(candX + 3.5, candY - 14),
        Paint()..color = const Color(0xFFD4AF37)..strokeWidth = 2.0,
      );

      // Wick
      canvas.drawLine(
        Offset(candX, candY - 26),
        Offset(candX, candY - 30),
        Paint()..color = const Color(0xFF3E2723)..strokeWidth = 1.2,
      );

      // 8. Flame and Smoke Animation using extinguishProgress
      final flameAlpha = (1.0 - extinguishProgress).clamp(0.0, 1.0);
      final smokeAlpha = extinguishProgress.clamp(0.0, 1.0);

      if (flameAlpha > 0.02) {
        // Flickering Dancing Flame
        final flickerOffset = (flickerProgress - 0.5) * 2.8 * (i == 1 ? -1 : 1);
        final flameX = candX + flickerOffset;
        final flameY = candY - 38 + (extinguishProgress * 4.0);
        final flameScale = 1.0 - (extinguishProgress * 0.35);

        // Outer Flame Halo Glow
        canvas.drawCircle(
          Offset(flameX, flameY),
          (9.5 + flickerProgress * 2.0) * flameScale,
          Paint()..color = const Color(0xFFFFD54F).withValues(alpha: 0.35 * flameAlpha),
        );

        // Flame Teardrop
        final flamePath = Path();
        flamePath.moveTo(flameX - 4.5 * flameScale, flameY + 6 * flameScale);
        flamePath.quadraticBezierTo(flameX - 5.5 * flameScale, flameY - 2 * flameScale, flameX, flameY - 9 * flameScale);
        flamePath.quadraticBezierTo(flameX + 5.5 * flameScale, flameY - 2 * flameScale, flameX + 4.5 * flameScale, flameY + 6 * flameScale);
        flamePath.close();

        canvas.drawPath(
          flamePath,
          Paint()
            ..shader = RadialGradient(
              colors: [
                const Color(0xFFFFF9C4).withValues(alpha: flameAlpha),
                const Color(0xFFFF9800).withValues(alpha: flameAlpha),
                const Color(0xFFFF3D00).withValues(alpha: flameAlpha),
              ],
            ).createShader(Rect.fromCircle(center: Offset(flameX, flameY), radius: 8 * flameScale)),
        );
      }

      if (smokeAlpha > 0.05) {
        // Delicate Smoke Curl drifting upward when extinguished
        final smokeRise = extinguishProgress * 12.0;
        final smokePath = Path();
        smokePath.moveTo(candX, candY - 30);
        smokePath.cubicTo(
          candX - 4 - (extinguishProgress * 3),
          candY - 36 - smokeRise * 0.4,
          candX + 6 + (extinguishProgress * 4),
          candY - 42 - smokeRise * 0.7,
          candX + 2,
          candY - 48 - smokeRise,
        );
        canvas.drawPath(
          smokePath,
          Paint()
            ..color = const Color(0xFF8D8D8D).withValues(alpha: 0.65 * smokeAlpha)
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round
            ..strokeWidth = 1.6,
        );
      }
    }

    // 9. 3D SLICE CUTTING & RED VELVET INTERIOR 🍰
    if (sliceProgress > 0) {
      final sliceOffset = sliceProgress * 50;
      final slicePath = Path();

      final startX = cx;
      final startY = cy - cakeHeight;

      slicePath.moveTo(startX, startY);
      slicePath.lineTo(cx + cakeRadiusX + sliceOffset, cy - cakeHeight + sliceOffset * 0.22);
      slicePath.lineTo(cx + cakeRadiusX + sliceOffset, cy + sliceOffset * 0.22);
      slicePath.lineTo(cx + sliceOffset * 0.5, cy + sliceOffset * 0.5);
      slicePath.close();

      // Red Velvet Sponge Base
      canvas.drawPath(
        slicePath,
        Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFF8B1220), Color(0xFF6A0C16)],
          ).createShader(slicePath.getBounds()),
      );
      canvas.drawPath(slicePath, lineOutline);

      // Cream Cheese Frosting Stripes inside cut wedge
      final cream1 = Path();
      cream1.moveTo(startX, startY + 14);
      cream1.lineTo(cx + cakeRadiusX + sliceOffset, cy - cakeHeight + 14 + sliceOffset * 0.22);
      cream1.lineTo(cx + cakeRadiusX + sliceOffset, cy - cakeHeight + 22 + sliceOffset * 0.22);
      cream1.lineTo(startX, startY + 22);
      cream1.close();
      canvas.drawPath(cream1, Paint()..color = const Color(0xFFFFFDF5));

      final cream2 = Path();
      cream2.moveTo(startX, startY + 32);
      cream2.lineTo(cx + cakeRadiusX + sliceOffset, cy - cakeHeight + 32 + sliceOffset * 0.22);
      cream2.lineTo(cx + cakeRadiusX + sliceOffset, cy - cakeHeight + 40 + sliceOffset * 0.22);
      cream2.lineTo(startX, startY + 40);
      cream2.close();
      canvas.drawPath(cream2, Paint()..color = const Color(0xFFFFFDF5));

      // Ruby Strawberry Jam Line
      final jamPath = Path();
      jamPath.moveTo(startX, startY + 22);
      jamPath.lineTo(cx + cakeRadiusX + sliceOffset, cy - cakeHeight + 22 + sliceOffset * 0.22);
      canvas.drawPath(
        jamPath,
        Paint()
          ..color = const Color(0xFFC2185B)
          ..strokeWidth = 2.4,
      );
    }

    // 10. Vintage Engraved Silver Cake Knife with Pink Ribbon Bow 🔪🎀
    final knifeHoverOffset = (knifeHover - 0.5) * 6;
    final knifeX = cx + 58 - (sliceProgress * 42) + (sliceProgress == 0 ? knifeHoverOffset : 0);
    final knifeY = cy - cakeHeight - 36 + (sliceProgress * 48);

    // Silver Blade with Beveled Shading
    final knifePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFECEFF1), Color(0xFFB0BEC5), Color(0xFFFFFFFF)],
      ).createShader(Rect.fromLTWH(knifeX, knifeY - 35, 75, 55));

    final knifePath = Path();
    knifePath.moveTo(knifeX, knifeY);
    knifePath.lineTo(knifeX + 68, knifeY - 34);
    knifePath.lineTo(knifeX + 74, knifeY - 28);
    knifePath.lineTo(knifeX + 16, knifeY + 14);
    knifePath.close();

    canvas.drawPath(knifePath, knifePaint);
    canvas.drawPath(knifePath, lineOutline);

    // Cute Pink Ribbon Bow on Knife Handle 🎀
    final bowX = knifeX + 58;
    final bowY = knifeY - 26;
    final bowPaint = Paint()..color = const Color(0xFFFF4081);

    canvas.drawCircle(Offset(bowX - 4, bowY - 2), 3.5, bowPaint);
    canvas.drawCircle(Offset(bowX + 4, bowY + 2), 3.5, bowPaint);
    canvas.drawCircle(Offset(bowX, bowY), 2.5, Paint()..color = const Color(0xFFD81B60));
  }

  @override
  bool shouldRepaint(covariant _Real3DCakePainter oldDelegate) =>
      oldDelegate.sliceProgress != sliceProgress ||
      oldDelegate.isCut != isCut ||
      oldDelegate.candlesBlown != candlesBlown ||
      oldDelegate.extinguishProgress != extinguishProgress ||
      oldDelegate.flickerProgress != flickerProgress ||
      oldDelegate.knifeHover != knifeHover;
}

