import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

/// Interactive "Paw Express" Kitten Delivery Service
/// A delightful, warm, aesthetic luxury airmail parcel service:
/// - Clean boutique ivory airmail parcel card with vintage postmarks & tracking
/// - 4 adorable couriers with preview avatars, unique cargo & handwritten postcards
/// - Interactive parcel acceptance with an animated wax seal stamp & floating heart bursts
/// - Per-courier delivery tracking with celebratory milestone when all 4 are unlocked
class KittenDeliveryService extends StatefulWidget {
  final bool isMobile;

  const KittenDeliveryService({super.key, required this.isMobile});

  @override
  State<KittenDeliveryService> createState() => _KittenDeliveryServiceState();
}

class _KittenDeliveryServiceState extends State<KittenDeliveryService>
    with TickerProviderStateMixin {
  int _selectedCourier = 0;
  final Set<int> _deliveredCouriers = {};
  int _hugsClaimed = 10000;

  late AnimationController _pulseController;
  late AnimationController _stampController;
  late Animation<double> _stampScaleAnimation;
  late Animation<double> _stampRotateAnimation;

  late AnimationController _burstController;
  final List<_FloatingParticle> _particles = [];
  final Random _rnd = Random();

  final List<Map<String, dynamic>> _couriers = [
    {
      "id": 0,
      "name": "Luna",
      "emoji": "🎀",
      "role": "Floral Courier",
      "image": "assets/photos/cat_flowers_bow.png",
      "accentColor": Color(0xFFE91E63),
      "badge": "FRESH BLOOMS",
      "cargo": "Hand-picked Pink Roses & Frangipani Bouquet",
      "cargoIcon": "🌸",
      "destination": "Selvakumar’s Warm Arms ♡",
      "specialNote":
          "Meow! Special delivery from Srinithi to Selvakumar! Warning: Contains 100% pure romance. Non-refundable because she already fell head-over-heels for you. Please sign with a forehead kiss! 🌸🐾",
      "actionLabel": "Accept Flower Delivery 🌸",
      "reward": "+100 FOREVER HUGS",
      "promoCode": "LUNA-ROSE-FOREVER",
    },
    {
      "id": 1,
      "name": "Turbo",
      "emoji": "🏎️",
      "role": "Speedster Courier",
      "image": "assets/photos/cat_hotwheels_strawberries.png",
      "accentColor": Color(0xFFFF5722),
      "badge": "EXPRESS 200 MPH",
      "cargo": "Hot Wheels GT Twin Turbo + Dipped Strawberries",
      "cargoIcon": "🏎️🍓",
      "destination": "The Best Boyfriend in the Universe ♡",
      "specialNote":
          "Vroom vroom! Dispatched at 200 MPH directly to the best boyfriend in the universe! P.S. Srinithi said no speeding without holding her hand! 🏎️🍓",
      "actionLabel": "Claim Hot Wheels & Berries 🏎️",
      "reward": "+500 SWEET KISSES",
      "promoCode": "TURBO-FAST-LOVE",
    },
    {
      "id": 2,
      "name": "Mochi",
      "emoji": "🎁",
      "role": "Surprise Vault",
      "image": "assets/photos/cat_tulips_giftbox.png",
      "accentColor": Color(0xFFD4AF37),
      "badge": "TOP SECRET VAULT",
      "cargo": "10,000+ Fight Apology & Cuddle Vouchers",
      "cargoIcon": "🎟️❤️",
      "destination": "Always Right (Except When Srinithi Says So) ♡",
      "specialNote":
          "Meow! This vault contains: 1x instant forehead kiss coupon, 10x cheek pinch passes, and unlimited daily fights that always end in ‘I love you’. Valid for 100 lifetimes! 🎁❤️",
      "actionLabel": "Redeem Love Vouchers 🎟️",
      "reward": "+10,000 FIGHT PASSES",
      "promoCode": "MOCHI-NO-FIGHTS",
    },
    {
      "id": 3,
      "name": "Whiskers",
      "emoji": "🎂",
      "role": "Birthday Squad",
      "image": "assets/photos/birthday_kitten.jpg",
      "accentColor": Color(0xFF8E24AA),
      "badge": "VIP BIRTHDAY",
      "cargo": "Midnight Birthday Cake with Golden Sprinkles",
      "cargoIcon": "🎂✨",
      "destination": "Selvakumar’s Birthday Celebration Table ♡",
      "specialNote":
          "Happy Birthday, Selvakumar! I brought the sweetest birthday slice baked with love. Must be eaten while playing ‘Our Song’ on repeat! Happy Birthday, my favorite person! 🎂✨",
      "actionLabel": "Blow Candles with Whiskers 🕯️",
      "reward": "+INFINITE WISHES",
      "promoCode": "SELVA-OCT13-BIRTHDAY",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _stampScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 2.2, end: 0.95), weight: 70),
      TweenSequenceItem(tween: Tween<double>(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _stampController,
      curve: Curves.easeOutBack,
    ));
    _stampRotateAnimation = Tween<double>(
      begin: -0.25,
      end: -0.12,
    ).animate(CurvedAnimation(
      parent: _stampController,
      curve: Curves.easeOut,
    ));

    _burstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {
        if (_burstController.isAnimating) {
          setState(() {
            for (var p in _particles) {
              p.update();
            }
          });
        }
      });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _stampController.dispose();
    _burstController.dispose();
    super.dispose();
  }

  void _acceptDelivery(int courierIndex, String rewardText) {
    setState(() {
      _deliveredCouriers.add(courierIndex);
      _hugsClaimed += 500;
    });

    _stampController.forward(from: 0.0);
    _triggerBurst(rewardText);
  }

  void _giveMoreHugs() {
    setState(() {
      _hugsClaimed += 100;
    });
    _triggerBurst("+100 HUGS 🫂");
  }

  void _triggerBurst(String mainText) {
    _particles.clear();
    final emojis = ["❤️", "🐾", "🌸", "✨", "💕", "🎀"];
    for (int i = 0; i < 22; i++) {
      _particles.add(
        _FloatingParticle(
          x: 120 + _rnd.nextDouble() * 260,
          y: 260 + _rnd.nextDouble() * 120,
          vx: (_rnd.nextDouble() - 0.5) * 7,
          vy: -3.0 - _rnd.nextDouble() * 6.0,
          text: i == 0 ? mainText : emojis[_rnd.nextInt(emojis.length)],
          size: i == 0 ? 15.0 : (14.0 + _rnd.nextDouble() * 10.0),
        ),
      );
    }
    _burstController.forward(from: 0.0);
  }

  void _selectNextCourier() {
    setState(() {
      _selectedCourier = (_selectedCourier + 1) % _couriers.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.isMobile;
    final current = _couriers[_selectedCourier];
    final isCurrentDelivered = _deliveredCouriers.contains(_selectedCourier);
    final allDelivered = _deliveredCouriers.length == _couriers.length;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 820),
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9), // Warm boutique luxury ivory parchment
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE8D8C8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Airmail border decorative stripe along the top edge
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 6,
              child: CustomPaint(
                painter: _AirmailStripePainter(),
              ),
            ),

            // Subtle decorative watermark stamp in background
            Positioned(
              right: -25,
              bottom: -25,
              child: Opacity(
                opacity: 0.04,
                child: Text(
                  "🐾",
                  style: TextStyle(fontSize: 180, color: current["accentColor"] as Color),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 28,
                vertical: isMobile ? 22 : 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 4),

                  // 1. Header: Airmail Dispatch Station Bar
                  _buildHeader(isMobile, isCurrentDelivered),

                  const SizedBox(height: 18),

                  // 2. All Delivered Milestone Celebration Banner (if unlocked)
                  if (allDelivered) ...[
                    _buildAllDeliveredBanner(isMobile),
                    const SizedBox(height: 16),
                  ],

                  // 3. Courier Selector Tab Bar (Cute Avatars + Tags)
                  _buildCourierTabBar(isMobile),

                  const SizedBox(height: 22),

                  // 4. Main Parcel Presentation Card
                  _buildMainParcelCard(current, isCurrentDelivered, isMobile),

                  const SizedBox(height: 16),

                  // 5. Bottom Guarantee Colophon
                  _buildFooterColophon(),
                ],
              ),
            ),

            // Airmail border decorative stripe along the bottom edge
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 6,
              child: CustomPaint(
                painter: _AirmailStripePainter(),
              ),
            ),

            // Floating Reward Particles
            if (_particles.isNotEmpty)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _FloatingParticlePainter(_particles),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Top Airmail Header
  Widget _buildHeader(bool isMobile, bool isDelivered) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        // Left: Postal Postmark Badge
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFFFECEE),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE57373),
                  width: 1.2,
                ),
              ),
              child: const Text("🐾", style: TextStyle(fontSize: 15)),
            ),
            const SizedBox(width: 9),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "PAW EXPRESS",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 12 : 13.5,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF6A1A24),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE4EC),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "PRIORITY",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFC2185B),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  "TRACKING: #SS-1013-FOREVER • 13 OCT 2026",
                  style: AppTheme.monoStyle(
                    fontSize: 8.5,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF8C7A70),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Right: Hugs Bank Counter
        InkWell(
          onTap: _giveMoreHugs,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0F3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFFB2C1),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB2C1).withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("🫂", style: TextStyle(fontSize: 13)),
                const SizedBox(width: 5),
                Text(
                  "$_hugsClaimed HUGS",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: const Color(0xFFB71C1C),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }

  /// All 4 Couriers Completed Milestone
  Widget _buildAllDeliveredBanner(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4AF37),
          width: 1.4,
        ),
      ),
      child: Row(
        children: [
          const Text("🏆", style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ALL 4 SPECIAL DELIVERIES ACCEPTED!",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 11 : 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: const Color(0xFF7A5800),
                  ),
                ),
                Text(
                  "Selvakumar has officially claimed all of Srinithi's love, hugs & kisses for this lifetime!",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 9.5 : 10.5,
                    color: const Color(0xFF5A4400),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Text("💖", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  /// 4 Courier Selection Tab Bar
  Widget _buildCourierTabBar(bool isMobile) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_couriers.length, (idx) {
          final c = _couriers[idx];
          final isSelected = _selectedCourier == idx;
          final isDelivered = _deliveredCouriers.contains(idx);
          final accent = c["accentColor"] as Color;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.5),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCourier = idx;
                });
              },
              borderRadius: BorderRadius.circular(18),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 10 : 14,
                  vertical: isMobile ? 6 : 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? accent.withValues(alpha: 0.10) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: isSelected ? accent : const Color(0xFFE8DCD1),
                    width: isSelected ? 1.8 : 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.20),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mini avatar circle
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? accent : const Color(0xFFD6C8B8),
                          width: 1.2,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          c["image"] as String,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      "${c["name"]} ${c["emoji"]}",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 11 : 12.5,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? const Color(0xFF2C1810) : const Color(0xFF706056),
                      ),
                    ),
                    if (isDelivered) ...[
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 13,
                        color: Color(0xFF2E7D32),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Main Delivery Parcel Stage
  Widget _buildMainParcelCard(
    Map<String, dynamic> current,
    bool isDelivered,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 14 : 22),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF6F0), // Soft warm cream card
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE4D5C5),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Content Layout: Stack on Mobile, 2-Column on Desktop
          isMobile
              ? Column(
                  children: [
                    _buildKittenPortrait(current, isDelivered, isMobile),
                    const SizedBox(height: 16),
                    _buildPostcardManifest(current, isDelivered, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildKittenPortrait(current, isDelivered, isMobile),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      flex: 6,
                      child: _buildPostcardManifest(current, isDelivered, isMobile),
                    ),
                  ],
                ),

          const SizedBox(height: 20),

          // Action Area
          _buildActionArea(current, isDelivered, isMobile),
        ],
      ),
    );
  }

  /// Left Side: Adorable Framed Kitten Portrait
  Widget _buildKittenPortrait(
    Map<String, dynamic> current,
    bool isDelivered,
    bool isMobile,
  ) {
    final accent = current["accentColor"] as Color;

    return Column(
      children: [
        // Photo Card with soft shadow & border
        Container(
          width: isMobile ? 160 : 200,
          height: isMobile ? 160 : 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: accent.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withValues(alpha: 0.18),
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              current["image"] as String,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Role & Badge Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: accent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                current["badge"] as String,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: accent,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),

        // Live Courier Mood Status
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDelivered ? const Color(0xFF2E7D32) : const Color(0xFFFF9800),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                isDelivered ? "Status: In Selva’s Hugs ♡" : "Status: Waiting at Door 🐾",
                textAlign: TextAlign.center,
                style: AppTheme.monoStyle(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                  color: isDelivered ? const Color(0xFF2E7D32) : const Color(0xFF8C7A70),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Right Side: Authentic Vintage Dispatch Postcard & Manifest
  Widget _buildPostcardManifest(
    Map<String, dynamic> current,
    bool isDelivered,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE8DDD2),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Postcard Top Bar: Destination & Cute Stamp
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SPECIAL DELIVERY FOR:",
                          style: AppTheme.monoStyle(
                            fontSize: 8.5,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF8C7A70),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Selvakumar (My Birthday Boy)",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 12 : 13.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF3E1D24),
                          ),
                        ),
                        Text(
                          current["destination"] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF8A6C58),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Cute Postal Stamp Icon
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4F6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFFE57373),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text("💌", style: TextStyle(fontSize: 12)),
                        Text(
                          "100% LOVE",
                          style: AppTheme.monoStyle(
                            fontSize: 7,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFC2185B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Divider(color: Color(0xFFF0E5D8), thickness: 1),
              const SizedBox(height: 8),

              // Cargo Tag
              Row(
                children: [
                  Text(
                    current["cargoIcon"] as String,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "CARGO: ${current["cargo"]}",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 10.5 : 11.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF5D2E18),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Srinithi's Handwritten Note
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF2), // Warm sandalwood parchment
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFEFE2CE),
                    width: 1,
                  ),
                ),
                child: Text(
                  current["specialNote"] as String,
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 16.5 : 18.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2C1810),
                    height: 1.25,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Sign-off signature
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "— Dispatched with infinite love, Srinithi ♡ 🐾",
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 14 : 15.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8C3848),
                  ),
                ),
              ),
            ],
          ),

          // If Delivered: Realistic Red Wax Stamp Overlay!
          if (isDelivered)
            Positioned(
              right: 8,
              bottom: 24,
              child: AnimatedBuilder(
                animation: _stampController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _stampRotateAnimation.value,
                    child: Transform.scale(
                      scale: _stampScaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB71C1C).withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFFD54F),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB71C1C).withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "CERTIFIED DELIVERED",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "S ♡ S • FOREVER",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 7.5,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFFFE082),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Action Area: Accept Delivery Button or Post-Delivery Controls
  Widget _buildActionArea(
    Map<String, dynamic> current,
    bool isDelivered,
    bool isMobile,
  ) {
    if (!isDelivered) {
      // Unclaimed State: Big Juicy Button to Accept Delivery
      return InkWell(
        onTap: () => _acceptDelivery(_selectedCourier, current["reward"] as String),
        borderRadius: BorderRadius.circular(30),
        child: AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_pulseController.value * 0.02),
              child: child,
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFC2185B), // Romantic Raspberry
                  Color(0xFF880E4F), // Deep Wine
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFFFFD54F),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFC2185B).withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("🐾", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    current["actionLabel"] as String,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 12.5 : 14.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text("💌", style: TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // Delivered State: Success Notice + Next Delivery / Give More Hugs Actions
      return Column(
        children: [
          // Reward Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF81C784),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 16),
                const SizedBox(width: 8),
                Text(
                  "CARGO CLAIMED: ${current["reward"]} CREDITED TO SELVA!",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 10 : 11.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1B5E20),
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Two Action Buttons: More Hugs & Next Courier
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _giveMoreHugs,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F3),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFFFB2C1),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("🫂", style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          "Give More Hugs (+100)",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 11 : 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB71C1C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: _selectNextCourier,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A148C), Color(0xFF311B92)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("🐾", style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Text(
                          "Next Courier ➔",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 11 : 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  /// Bottom Colophon & Policy Guarantee
  Widget _buildFooterColophon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.verified, size: 12, color: Color(0xFFD4AF37)),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            "Paw Express Guarantee: Srinithi loves Selvakumar 10,000% forever. Non-refundable.",
            textAlign: TextAlign.center,
            style: AppTheme.monoStyle(
              fontSize: 9,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8C7A70),
            ),
          ),
        ),
      ],
    );
  }
}

/// Floating Particle for Heart / Paw / Reward Burst
class _FloatingParticle {
  double x;
  double y;
  double vx;
  double vy;
  String text;
  double size;

  _FloatingParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.text,
    required this.size,
  });

  void update() {
    x += vx;
    y += vy;
    vy += 0.06;
    size = max(0.0, size - 0.22);
  }
}

class _FloatingParticlePainter extends CustomPainter {
  final List<_FloatingParticle> particles;

  _FloatingParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    for (var p in particles) {
      if (p.size <= 0) continue;
      final textSpan = TextSpan(
        text: p.text,
        style: TextStyle(fontSize: p.size),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(p.x, p.y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Vintage Airmail Stripe Painter (Red and Blue angled stripes)
class _AirmailStripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final redPaint = Paint()..color = const Color(0xFFE53935);
    final bluePaint = Paint()..color = const Color(0xFF1E88E5);
    final whitePaint = Paint()..color = const Color(0xFFFFFDF9);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), whitePaint);

    const stripeWidth = 14.0;
    const stripeGap = 6.0;
    final totalPatternWidth = (stripeWidth * 2) + (stripeGap * 2);

    int count = (size.width / totalPatternWidth).ceil() + 2;

    for (int i = 0; i < count; i++) {
      double startX = i * totalPatternWidth;

      // Red parallelogram
      Path redPath = Path()
        ..moveTo(startX, 0)
        ..lineTo(startX + stripeWidth, 0)
        ..lineTo(startX + stripeWidth - 4, size.height)
        ..lineTo(startX - 4, size.height)
        ..close();
      canvas.drawPath(redPath, redPaint);

      // Blue parallelogram
      double blueStartX = startX + stripeWidth + stripeGap;
      Path bluePath = Path()
        ..moveTo(blueStartX, 0)
        ..lineTo(blueStartX + stripeWidth, 0)
        ..lineTo(blueStartX + stripeWidth - 4, size.height)
        ..lineTo(blueStartX - 4, size.height)
        ..close();
      canvas.drawPath(bluePath, bluePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
