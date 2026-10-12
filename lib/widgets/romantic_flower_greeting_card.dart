import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/story_data.dart';
import '../utils/responsive.dart';
import 'kitten_delivery_service.dart';

/// Premium Romantic Interactive Birthday Greeting Card
/// "Flowers For You, My Sweetheart"
/// Recreates the reference design:
/// - Deep burgundy velvet background with floating petals
/// - Grayscale hands gently presenting an elegant cream card
/// - Realistic bouquet of pink roses in kraft paper
/// - Cursive white typography "Flowers For You, My Sweetheart"
/// - 8 sweet message bubbles around the bouquet
/// - Interactive tap-to-open birthday reveal with custom love letter & couple photo
/// - Replay animation button
class RomanticFlowerGreetingCard extends StatefulWidget {
  const RomanticFlowerGreetingCard({super.key});

  @override
  State<RomanticFlowerGreetingCard> createState() =>
      _RomanticFlowerGreetingCardState();
}

class _RomanticFlowerGreetingCardState extends State<RomanticFlowerGreetingCard>
    with TickerProviderStateMixin {
  late AnimationController _masterController;
  late AnimationController _petalController;
  late AnimationController _glowController;
  late AnimationController _flipController;

  // Animation Stages
  late Animation<double> _handsAndCardEntrance;
  late Animation<double> _bouquetScale;
  late Animation<double> _bouquetOpacity;
  late Animation<double> _titleOpacity;
  late Animation<double> _glowPulse;
  late Animation<double> _cardFlipAnimation;

  bool _isCardOpened = false;
  final List<_PetalParticle> _petals = [];
  final Random _random = Random();

  final List<Map<String, dynamic>> _messageBubbles = [
    {
      "text": "Thank You For Loving Me",
      "align": Alignment.topLeft,
      "dx": -0.55,
      "dy": -0.65,
    },
    {
      "text": "I'm Happiest When It's You",
      "align": Alignment.centerLeft,
      "dx": -0.65,
      "dy": -0.25,
    },
    {
      "text": "With you everything feels right",
      "align": Alignment.bottomLeft,
      "dx": -0.42,
      "dy": 0.28,
    },
    {
      "text": "I'd fall for you all over",
      "align": Alignment.bottomLeft,
      "dx": -0.30,
      "dy": 0.60,
    },
    {
      "text": "I Love You So Much",
      "align": Alignment.topRight,
      "dx": 0.58,
      "dy": -0.65,
    },
    {
      "text": "You feel like a home to me",
      "align": Alignment.centerRight,
      "dx": 0.62,
      "dy": -0.22,
    },
    {
      "text": "Loving you is my favorite thing",
      "align": Alignment.bottomRight,
      "dx": 0.45,
      "dy": 0.25,
    },
    {
      "text": "My heart chose you",
      "align": Alignment.bottomRight,
      "dx": 0.40,
      "dy": 0.58,
    },
  ];

  @override
  void initState() {
    super.initState();

    // 1. Master Sequence Animation Controller (Entrance flow)
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    // Hands and Card Entrance (0.0 -> 0.4)
    _handsAndCardEntrance = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.0, 0.40, curve: Curves.easeOutBack),
    );

    // Bouquet Scale & Fade (0.35 -> 0.65)
    _bouquetScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOutBack),
      ),
    );
    _bouquetOpacity = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.35, 0.60, curve: Curves.easeIn),
    );

    // Title Headline (0.50 -> 0.75)
    _titleOpacity = CurvedAnimation(
      parent: _masterController,
      curve: const Interval(0.50, 0.75, curve: Curves.easeIn),
    );

    // 2. Ambient Petals Floating Controller
    _petalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Generate random falling petals
    for (int i = 0; i < 24; i++) {
      _petals.add(
        _PetalParticle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          size: 10 + _random.nextDouble() * 16,
          speed: 0.2 + _random.nextDouble() * 0.4,
          sway: _random.nextDouble() * 2 * pi,
          rotation: _random.nextDouble() * 2 * pi,
          rotationSpeed: (_random.nextDouble() - 0.5) * 1.5,
          opacity: 0.35 + _random.nextDouble() * 0.45,
        ),
      );
    }

    // 3. Ambient Glow Pulse Controller
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _glowPulse = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // 4. Card Flip Reveal Controller (when user taps to open)
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _cardFlipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOutBack,
    );

    // Launch master sequence
    _masterController.forward();
  }

  @override
  void dispose() {
    _masterController.dispose();
    _petalController.dispose();
    _glowController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  void _replayAnimation() {
    setState(() {
      _isCardOpened = false;
    });
    _flipController.reverse();
    _masterController.reset();
    _masterController.forward();
  }

  void _toggleCardOpen() {
    setState(() {
      _isCardOpened = !_isCardOpened;
    });
    if (_isCardOpened) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 680),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.0, -0.1),
          radius: 1.2,
          colors: [
            Color(0xFF5A0813), // Rich Velvet Burgundy Center Glow
            Color(0xFF380309), // Deep Wine Red
            Color(0xFF1E0105), // Dark Mahogany Outer Edge
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Floating Flower Petals Particle Canvas
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _petalController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _FallingPetalsPainter(
                    progress: _petalController.value,
                    petals: _petals,
                  ),
                );
              },
            ),
          ),

          // 2. Corner Blush Flowers (Top Left & Top Right)
          _buildCornerBlossom(isTopLeft: true, isMobile: isMobile),
          _buildCornerBlossom(isTopLeft: false, isMobile: isMobile),

          // 3. Main Center Content Column
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? 32 : 48,
              horizontal: isMobile ? 12 : 28,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Headline: "Flowers For You, My Sweetheart"
                FadeTransition(
                  opacity: _titleOpacity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Flowers For You, My Sweetheart",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alexBrush(
                        fontSize: isMobile ? 36 : 58,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: const Color(0xFFFF8DA1).withValues(alpha: 0.6),
                            blurRadius: 18,
                            offset: const Offset(0, 2),
                          ),
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.6),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Interactive Greeting Card & Hands Presentation
                ScaleTransition(
                  scale: _handsAndCardEntrance,
                  child: GestureDetector(
                    onTap: _toggleCardOpen,
                    child: AnimatedBuilder(
                      animation: _cardFlipAnimation,
                      builder: (context, child) {
                        final flipVal = _cardFlipAnimation.value;
                        final angle = flipVal * pi;

                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001) // 3D Perspective
                            ..rotateY(angle),
                          alignment: Alignment.center,
                          child: flipVal < 0.5
                              ? _buildCardFront(isMobile)
                              : Transform(
                                  transform: Matrix4.identity()..rotateY(pi),
                                  alignment: Alignment.center,
                                  child: _buildCardInsideReveal(isMobile),
                                ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Replay & Hint Action Bar
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    // Interactive Tap Hint Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isCardOpened
                                ? Icons.flip_to_back_rounded
                                : Icons.touch_app_rounded,
                            size: 15,
                            color: const Color(0xFFFFD700),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isCardOpened
                                ? "Tap to close card"
                                : "Tap card to open message ♡",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: const Color(0xFFFDE8E9),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Replay Animation Button
                    InkWell(
                      onTap: _replayAnimation,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.replay_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Replay",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

                const SizedBox(height: 36),

                // Interactive Cute Kitten Deliveries Service
                KittenDeliveryService(isMobile: isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Front View of the Greeting Card (The reference layout)
  Widget _buildCardFront(bool isMobile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = isMobile ? min(screenWidth - 32, 360.0) : 760.0;
    final cardHeight = isMobile ? 260.0 : 440.0;

    return AnimatedBuilder(
      animation: _glowPulse,
      builder: (context, child) {
        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF69B4)
                    .withValues(alpha: 0.18 * _glowPulse.value),
                blurRadius: 40,
                spreadRadius: 8,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Hands and Cream Card Presentation Background
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/photos/hands_presenting_card.jpg",
              width: cardWidth,
              height: cardHeight,
              fit: BoxFit.cover,
            ),
          ),

          // 2. Vintage Stamp / Date Ticket on the left edge
          Positioned(
            left: isMobile ? 12 : 24,
            bottom: isMobile ? 40 : 80,
            child: _buildVintageTicket(isMobile),
          ),

          // 3. Centered Realistic Bouquet of Pink Roses
          Positioned(
            child: FadeTransition(
              opacity: _bouquetOpacity,
              child: ScaleTransition(
                scale: _bouquetScale,
                child: SizedBox(
                  width: isMobile ? 160 : 260,
                  height: isMobile ? 210 : 340,
                  child: Image.asset(
                    "assets/photos/rose_bouquet_kraft.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // 4. Surrounding 8 Sweet Speech Bubbles
          ..._messageBubbles.asMap().entries.map((entry) {
            final index = entry.key;
            final bubble = entry.value;

            return _buildAnimatedSpeechBubble(
              text: bubble["text"] as String,
              dx: (bubble["dx"] as double) * (isMobile ? 0.95 : 1.0),
              dy: (bubble["dy"] as double) * (isMobile ? 0.90 : 1.0),
              delayIndex: index,
              isMobile: isMobile,
            );
          }),

          // 5. Adorable Kitten Delivery Sticker on bottom-right corner
          Positioned(
            right: isMobile ? 8 : 22,
            bottom: isMobile ? -6 : -8,
            child: IgnorePointer(
              child: SizedBox(
                width: isMobile ? 75 : 110,
                height: isMobile ? 90 : 130,
                child: Image.asset(
                  "assets/photos/cat_flowers_bow.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Inside View of the Greeting Card (Revealed on Tap)
  Widget _buildCardInsideReveal(bool isMobile) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = isMobile ? min(screenWidth - 32, 360.0) : 760.0;
    final cardHeight = isMobile ? 480.0 : 440.0;

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 36,
        vertical: isMobile ? 18 : 32,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F1), // Cream Vintage Cardstock
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: const Color(0xFFFF69B4).withValues(alpha: 0.25),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Script greeting
          Text(
            "oh hello happy birthday my cutie may god bless you ♡",
            textAlign: TextAlign.center,
            style: GoogleFonts.caveat(
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E2723),
            ),
          ),

          // Center Section: Couple Photo & Birthday Title
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Polaroid Couple Photo
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: SizedBox(
                          width: isMobile ? 90 : 160,
                          height: isMobile ? 110 : 190,
                          child: Image.asset(
                            "assets/photos/traditional_couple.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Forever Us ♡",
                        style: GoogleFonts.caveat(
                          fontSize: isMobile ? 12 : 14,
                          color: const Color(0xFF5D4037),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isMobile ? 10 : 32),

                // Romantic Dedication & Sunflower Title
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "HAPPY BIRTHDAY,",
                        style: GoogleFonts.cinzel(
                          fontSize: isMobile ? 18 : 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                          color: const Color(0xFF1B1B1B),
                        ),
                      ),
                      Text(
                        "MY SUNFLOWER 🌻",
                        style: GoogleFonts.cinzel(
                          fontSize: isMobile ? 18 : 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2.0,
                          color: const Color(0xFFB8860B),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        StoryConfig.boyName.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: isMobile ? 14 : 18,
                          letterSpacing: 3.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF8B0000),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "“${StoryConfig.birthdayMessage}”",
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: isMobile ? 14 : 17,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4A4A4A),
                          height: 1.4,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Seal & Sign-Off
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "★ Special 2026 Edition",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isMobile ? 10 : 12,
                  letterSpacing: 1.5,
                  color: const Color(0xFF8D6E63),
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Cute Gift Box Kitten Sticker
              Image.asset(
                "assets/photos/cat_tulips_giftbox.png",
                height: isMobile ? 55 : 75,
                fit: BoxFit.contain,
              ),

              Text(
                "All My Love, Srinithi ♡",
                style: GoogleFonts.greatVibes(
                  fontSize: isMobile ? 22 : 28,
                  color: const Color(0xFF8B0000),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Animated Speech Bubble helper
  Widget _buildAnimatedSpeechBubble({
    required String text,
    required double dx,
    required double dy,
    required int delayIndex,
    required bool isMobile,
  }) {
    // Staggered pop-in animation
    final startInterval = 0.55 + (delayIndex * 0.05);
    final endInterval = (startInterval + 0.20).clamp(0.0, 1.0);

    final bubbleAnim = CurvedAnimation(
      parent: _masterController,
      curve: Interval(startInterval, endInterval, curve: Curves.elasticOut),
    );

    return Align(
      alignment: Alignment(dx, dy),
      child: ScaleTransition(
        scale: bubbleAnim,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 10 : 14,
            vertical: isMobile ? 5 : 7,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE0D8D0),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 9.5 : 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C1810),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  /// Vintage ticket stamp on the left side
  Widget _buildVintageTicket(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 12,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E9DC),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFBFA588),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "OCT 13",
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 9 : 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: const Color(0xFF4A2810),
            ),
          ),
          Text(
            "BIRTHDAY",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 7 : 8.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              color: const Color(0xFF8B0000),
            ),
          ),
        ],
      ),
    );
  }

  /// Corner Blush Cherry Blossom Widget
  Widget _buildCornerBlossom({
    required bool isTopLeft,
    required bool isMobile,
  }) {
    final size = isMobile ? 120.0 : 220.0;

    return Positioned(
      top: isTopLeft ? -20 : -20,
      left: isTopLeft ? -20 : null,
      right: isTopLeft ? null : -20,
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _glowPulse,
          builder: (context, child) {
            return Transform.rotate(
              angle: isTopLeft ? -0.2 : 0.2,
              child: Transform.scale(
                scale: 0.95 + 0.05 * _glowPulse.value,
                child: SizedBox(
                  width: size,
                  height: size,
                  child: Opacity(
                    opacity: 0.88,
                    child: Image.asset(
                      "assets/photos/blush_pink_blossom.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Floating Petal Model
class _PetalParticle {
  double x;
  double y;
  final double size;
  final double speed;
  final double sway;
  double rotation;
  final double rotationSpeed;
  final double opacity;

  _PetalParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.sway,
    required this.rotation,
    required this.rotationSpeed,
    required this.opacity,
  });
}

/// Custom Falling Petals Painter
class _FallingPetalsPainter extends CustomPainter {
  final double progress;
  final List<_PetalParticle> petals;

  _FallingPetalsPainter({
    required this.progress,
    required this.petals,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in petals) {
      final currentY = (p.y + progress * p.speed) % 1.0;
      final currentX = (p.x + sin((progress * 2 * pi) + p.sway) * 0.04) % 1.0;

      final posX = currentX * size.width;
      final posY = currentY * size.height;
      final currentRotation = p.rotation + (progress * p.rotationSpeed * pi);

      canvas.save();
      canvas.translate(posX, posY);
      canvas.rotate(currentRotation);

      paint.color = const Color(0xFFFFB6C1).withValues(alpha: p.opacity * 0.7);

      // Draw oval petal with subtle gradient illusion
      final petalRect = Rect.fromCenter(
        center: Offset.zero,
        width: p.size,
        height: p.size * 0.65,
      );
      canvas.drawOval(petalRect, paint);

      // Subtle petal highlight
      paint.color = Colors.white.withValues(alpha: p.opacity * 0.35);
      final highlightRect = Rect.fromCenter(
        center: const Offset(-2, -1),
        width: p.size * 0.5,
        height: p.size * 0.3,
      );
      canvas.drawOval(highlightRect, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _FallingPetalsPainter oldDelegate) => true;
}


