import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

/// Credit entry for the 100 Pet Names Reel
class PetNameCredit {
  final String title;
  final String description;
  const PetNameCredit(this.title, this.description);
}

/// "WHO IS HE?" — Cinematic Movie Credits Pet Name Reel
/// Displays:
/// - Selvakumar & Srinithi's couple car photo (with toggle to gym photo)
/// - Bold "HE IS ⬅" pointer in the middle
/// - Upward-scrolling Hollywood movie end credits of 100 affectionate pet names & sweet descriptions
/// - Smooth shader fade for cinematic reel effect
class WhoIsHeMovieCreditsSection extends StatefulWidget {
  const WhoIsHeMovieCreditsSection({super.key});

  @override
  State<WhoIsHeMovieCreditsSection> createState() =>
      _WhoIsHeMovieCreditsSectionState();
}

class _WhoIsHeMovieCreditsSectionState extends State<WhoIsHeMovieCreditsSection>
    with TickerProviderStateMixin {
  late AnimationController _scrollController;
  late AnimationController _arrowPulseController;
  late AnimationController _heartBurstController;

  final List<_FloatingHeart> _hearts = [];
  final Random _rnd = Random();
  bool _isPaused = false;
  int _selectedNameIndex = -1;
  bool _showCoupleCarPhoto = true;

  // The comprehensive list of 100 affectionate nicknames & sweet descriptions
  static const List<PetNameCredit> _petNames = [
    PetNameCredit("my pookie", "The adorable nickname that brings an instant smile to my face whenever I say it."),
    PetNameCredit("my love", "The deepest affection of my soul, representing a bond that grows stronger with every passing day."),
    PetNameCredit("my life", "The absolute center of my universe, around whom all my happiest plans and dreams revolve."),
    PetNameCredit("my baby", "The wonderful man I love to comfort, cherish, protect, and spoil with endless warmth and affection."),
    PetNameCredit("my significant other", "My equal partner in this wild journey, standing beside me through every single high and low."),
    PetNameCredit("my darling", "A timeless, sweet expression for the person who holds the most special place inside my heart."),
    PetNameCredit("my boy", "My forever crush, the charming guy who still gives me butterflies just like the very first day."),
    PetNameCredit("my handsome", "The stunning man whose smile completely lights up the darkest rooms and brightens my entire mood."),
    PetNameCredit("my forever", "The one true person I choose to walk beside today, tomorrow, and for all eternity."),
    PetNameCredit("my king", "The protector of our home who rules my heart with his incredible kindness and gentle strength."),
    PetNameCredit("my protector", "The strong, steady shield who makes me feel entirely safe and secure whenever he is near."),
    PetNameCredit("my provider", "The hardworking, dedicated partner who always goes above and beyond to care for our beautiful family."),
    PetNameCredit("my soulmate", "The perfect match destined for me, connected deeply on a level that defies all ordinary explanation."),
    PetNameCredit("my rock", "The solid, unshakeable foundation I lean on whenever life becomes overwhelming, chaotic, or incredibly difficult."),
    PetNameCredit("my anchor", "The steady presence keeping me grounded and calm when the stormy waves of life crash around us."),
    PetNameCredit("my sunshine", "The bright, radiant beam of light who chases away the gloomiest shadows with his infectious laughter."),
    PetNameCredit("my treasure", "A rare, priceless gem that I promise to value, honor, and protect for all my days."),
    PetNameCredit("my home", "The warm, comforting place where my heart always feels completely safe, accepted, and at total peace."),
    PetNameCredit("my refuge", "My quiet sanctuary from the noisy world, where all my stress melts away instantly in his arms."),
    PetNameCredit("my happiness", "The pure, unmatched source of my deepest joy, sweetest smiles, and most profound contentment in life."),
    PetNameCredit("my everything", "The complete package of lover, helper, and guide who fulfills every single hope I ever had."),
    PetNameCredit("my heart", "The central rhythm beating inside my chest, keeping me alive, vibrant, hopeful, and deeply inspired."),
    PetNameCredit("my world", "The vast, beautiful landscape where all my favorite memories are created and shared alongside him daily."),
    PetNameCredit("my best friend", "The trusted confidant who knows every secret, shares my humor, and listens without any judgment."),
    PetNameCredit("my companion", "My loyal, steady traveler on this long, unpredictable road of life, walking step for step with me."),
    PetNameCredit("my cheerleader", "The enthusiastic supporter who constantly believes in my dreams, cheering loudest for my every success."),
    PetNameCredit("my defender", "The fiercely loyal ally who always takes my side and stands up for me no matter what."),
    PetNameCredit("my guide", "The wise, thoughtful counselor whose steady advice helps me navigate the most confusing paths in life."),
    PetNameCredit("my inspiration", "The brilliant example of goodness and hard work that motivates me to become a better person daily."),
    PetNameCredit("my motivation", "The powerful driving force that pushes me to wake up and strive for a brighter future."),
    PetNameCredit("my blessing", "A beautiful, divine gift from above that fills my life with endless gratitude, peace, and wonder."),
    PetNameCredit("my miracle", "The extraordinary proof that beautiful, magical things really do happen to ordinary people like me."),
    PetNameCredit("my dream come true", "The living, breathing reality of the perfect man I used to wish for long ago."),
    PetNameCredit("my partner in crime", "My favorite mischievous accomplice for spontaneous late-night drives, fun adventures, and hilarious inside jokes."),
    PetNameCredit("my better half", "The superior part of our union who beautifully balances out all my flaws and weaknesses."),
    PetNameCredit("my missing piece", "The exact puzzle component that finally fit perfectly to make my entire life feel complete."),
    PetNameCredit("my true north", "The reliable, unwavering compass that always guides me back to what truly matters most in life."),
    PetNameCredit("my sweet pea", "A tender, endearing term for the gentlest soul who fills our home with quiet joy."),
    PetNameCredit("my heartbeat", "The constant, reassuring reminder of the vibrant love that keeps our relationship moving forward beautifully."),
    PetNameCredit("my daydream", "The beautiful, distracting thought that occupies my mind during long, busy hours at work every day."),
    PetNameCredit("my favorite distraction", "The handsome disrupter who can easily make me forget all my tasks with one look."),
    PetNameCredit("my comfort zone", "The cozy, warm embrace where I can shed all masks and be entirely myself."),
    PetNameCredit("my safe haven", "The peaceful harbor where no harm can touch me as long as we are together."),
    PetNameCredit("my constant", "The one reliable, unchanging certainty in a rapidly shifting world that often feels totally unpredictable."),
    PetNameCredit("my guiding light", "The bright beacon that helps me see clearly when the path ahead looks dark."),
    PetNameCredit("my sweet man", "The gentle, affectionate soul who treats me with the utmost respect, care, and tenderness."),
    PetNameCredit("my true love", "The authentic, undeniable romance that redefined the meaning of affection and commitment for me."),
    PetNameCredit("my soft place to land", "The comforting, supportive space that cushions me whenever I fall or stumble."),
    PetNameCredit("my greatest adventure", "The thrilling, joyful journey of marriage that brings something new and wonderful every single day."),
    PetNameCredit("my forever date", "The handsome partner I always want sitting across from me at every single dinner table."),
    PetNameCredit("my favorite hello", "The wonderful greeting that instantly erases a long day, and my hardest, most reluctant goodbye."),
    PetNameCredit("my piece of heaven", "The beautiful slice of paradise I get to experience right here on earth with him."),
    PetNameCredit("my angel", "The kind, selfless human who watches over me with unconditional love and an open heart."),
    PetNameCredit("my heart’s desire", "The singular focus of all my romantic thoughts, wishes, and deepest longings over time."),
    PetNameCredit("my light", "The brilliant spark that illuminated my path and showed me how beautiful a partnership can be."),
    PetNameCredit("my joy", "The bubbling fountain of pure happiness that keeps my spirits high even during difficult times."),
    PetNameCredit("my calm", "The soothing, tranquil force that instantly quietens my anxious thoughts and brings me back to peace."),
    PetNameCredit("my sanctuary", "The sacred, quiet space of love we built together away from the chaos of society."),
    PetNameCredit("my strongman", "The capable, resilient partner who carries heavy burdens easily so I never have to struggle."),
    PetNameCredit("my favorite view", "The stunning sight of him smiling, laughing, or simply relaxing at home after a long day."),
    PetNameCredit("my destiny", "The beautiful destination my life was always moving toward before I even realized it myself."),
    PetNameCredit("my champion", "The brave supporter who fights for our happiness and handles every challenge with grace."),
    PetNameCredit("my prize", "The greatest reward life has ever given me, far exceeding any trophy or accolade imaginable."),
    PetNameCredit("my favorite person", "The first individual I want to call with good news or bad news, always."),
    PetNameCredit("my dynamic partner", "The energetic, capable teammate who makes running a household feel like fun, cooperative play."),
    PetNameCredit("my main man", "The absolute star of my life's story, holding the undisputed lead role forever and ever."),
    PetNameCredit("my shining star", "The brilliant guide who stands out effortlessly in any crowd, drawing my eyes right to him."),
    PetNameCredit("my absolute favorite", "The supreme choice above all other things, places, or people in this wide world."),
    PetNameCredit("my cuddle buddy", "The warm, perfect fit for cozy rainy days, movie nights, and lazy Sunday mornings."),
    PetNameCredit("my forever valentine", "The romantic partner I will proudly celebrate every single day of the year, endlessly."),
    PetNameCredit("my pillow talk partner", "The deep thinker who shares profound midnight conversations and sleepy morning giggles with me."),
    PetNameCredit("my sweet relief", "The relaxing antidote to a stressful world, bringing instant comfort with a simple hug."),
    PetNameCredit("my love bug", "The cute, affectionate nickname for the moments when we are just being silly together."),
    PetNameCredit("my heartbeat rhythm", "The steady, soothing sound I listen to when resting my head upon his broad chest."),
    PetNameCredit("my perfect match", "The ideal blend of personality, values, and humor that complements my own nature beautifully."),
    PetNameCredit("my anchor in the storm", "The unwavering force keeping our family safe and steady when challenges arise unexpectedly."),
    PetNameCredit("my daily dose of happy", "The reliable routine of love, smiles, and laughter that keeps my mood elevated."),
    PetNameCredit("my dream keeper", "The trusted guardian who holds my biggest aspirations safely and helps me build them."),
    PetNameCredit("my ultimate supporter", "The dedicated advocate who lifts me up and never lets me doubt my worth."),
    PetNameCredit("my handsome gentleman", "The polite, charming partner who treats me with chivalry and deep respect every day."),
    PetNameCredit("my lifetime co-pilot", "The trusted navigator steering our shared life toward happiness, adventure, success, and prosperity."),
    PetNameCredit("my biggest blessing", "The profound gift that makes me count my lucky stars every morning I wake up."),
    PetNameCredit("my quiet confidence", "The supportive presence that makes me feel bold enough to face any external challenge."),
    PetNameCredit("my safety net", "The absolute certainty that someone will always catch me if things go completely wrong."),
    PetNameCredit("my forever honey", "The sweet, enduring love of my life who never loses his delightful charm or warmth."),
    PetNameCredit("my bright tomorrow", "The beautiful promise of a happy future that makes growing older feel exciting."),
    PetNameCredit("my sweet solace", "The peaceful remedy for a weary mind, providing a quiet space to heal and rest."),
    PetNameCredit("my number one", "The absolute priority who takes first place in my heart, mind, and daily schedule."),
    PetNameCredit("my favorite place", "Not a geographical location on a map, but standing right by his side anywhere."),
    PetNameCredit("my happy place", "The joyful state of mind I enter the exact moment he looks at me."),
    PetNameCredit("my daily grin", "The hilarious comedian who can make me laugh out loud with just a single expression."),
    PetNameCredit("my steady hand", "The reliable partner who keeps things moving smoothly when I feel overwhelmed by life."),
    PetNameCredit("my proudest choice", "The wonderful decision to say \"I do\" that I would repeat a million times over."),
    PetNameCredit("my lifetime sweetie", "The darling man whose affection remains as fresh as the day we first fell in love."),
    PetNameCredit("my shelter", "The protective canopy that keeps the harsh elements of life from ever reaching my spirit."),
    PetNameCredit("my bright spark", "The creative, energetic mind that keeps our daily routine feeling fresh, vibrant, and fun."),
    PetNameCredit("my ultimate comfort", "The simple, uncomplicated feeling of being known, loved, and fully accepted by my husband."),
    PetNameCredit("my soft heart", "The empathetic, caring man whose kindness toward others makes me fall in love all over again."),
    PetNameCredit("my favorite habit", "The comforting routine of kissing him goodbye every morning and greeting him every single evening."),
    PetNameCredit("my golden boy", "The precious, wonderful man who brings nothing but pure warmth and value into my life."),
    PetNameCredit("my beautiful reality", "The waking life that is vastly superior to any dream I could have ever imagined."),
  ];

  static const double _itemHeight = 64.0;

  @override
  void initState() {
    super.initState();

    // 85 seconds for a serene, movie-like scroll through all 100 entries
    _scrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 85),
    )..repeat();

    _arrowPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _heartBurstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {
        if (_heartBurstController.isAnimating) {
          setState(() {
            for (var h in _hearts) {
              h.update();
            }
          });
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _arrowPulseController.dispose();
    _heartBurstController.dispose();
    super.dispose();
  }

  void _triggerHearts(String name) {
    _hearts.clear();
    for (int i = 0; i < 20; i++) {
      _hearts.add(
        _FloatingHeart(
          x: 100 + _rnd.nextDouble() * 260,
          y: 180 + _rnd.nextDouble() * 120,
          vx: (_rnd.nextDouble() - 0.5) * 7,
          vy: -3.0 - _rnd.nextDouble() * 5.0,
          text: i == 0 ? "❤️ $name" : (i % 2 == 0 ? "💕" : "✨"),
          size: i == 0 ? 14.0 : (12.0 + _rnd.nextDouble() * 10.0),
        ),
      );
    }
    _heartBurstController.forward(from: 0.0);
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _scrollController.stop();
      } else {
        _scrollController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final cardMaxWidth = isMobile ? 480.0 : 860.0;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: cardMaxWidth),
      margin: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94), // Luxurious Pearl White / Pure Ivory
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.50), // Fine Champagne Gold Hairline
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B1220).withValues(alpha: 0.08),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 14 : 28,
                vertical: isMobile ? 20 : 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Cinema Film Perforations / Sprocket Strip (Top)
                  _buildFilmPerforations(),
                  const SizedBox(height: 8),

                  // 1. Cinema Clapperboard End Card Header
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B1220).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("🎬", style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 7),
                          Text(
                            "OFFICIAL MOVIE END CARD  ·  STARRING SELVAKUMAR",
                            style: AppTheme.monoStyle(
                              fontSize: isMobile ? 9.5 : 11,
                              letterSpacing: 2.0,
                              color: const Color(0xFF8B1220),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 7),
                          const Text("⭐", style: TextStyle(fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Clapper Slate Metadata
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "SCENE: FOREVER  ·  TAKE: 24  ·  DIRECTOR: SRINITHI  ·  STUDIO: DESTINY",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 11 : 12.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                        color: const Color(0xFF8B1220).withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Giant Royal Burgundy & Gold Movie Title
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xFF8B1220),
                            Color(0xFF5A0E18),
                            Color(0xFF38080E),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      child: Text(
                        "“WHO IS HE?”",
                        style: GoogleFonts.cinzel(
                          fontSize: isMobile ? 32 : 46,
                          fontWeight: FontWeight.w900,
                          letterSpacing: isMobile ? 3.0 : 6.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "Written in the stars, certified in my heart ♡",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 15 : 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4E342E),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. The Movie Credits Assembly (Desktop vs Mobile)
                  isMobile ? _buildMobileLayout() : _buildDesktopLayout(),

                  const SizedBox(height: 20),

                  // 3. Bottom Controls & 100 Pet Names Counter Badge
                  _buildBottomBar(isMobile),
                  const SizedBox(height: 14),

                  // Cinema Film Perforations / Sprocket Strip (Bottom)
                  _buildFilmPerforations(),
                ],
              ),
            ),

            // 4. Floating Love Sparkles
            ..._hearts.map((h) {
              return Positioned(
                left: h.x,
                top: h.y,
                child: Opacity(
                  opacity: h.opacity,
                  child: Text(
                    h.text,
                    style: TextStyle(
                      fontSize: h.size,
                      color: const Color(0xFFFF80AB),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Desktop Layout: Horizontal 3-element row (Photo | HE IS ⬅ | Upward Scrolling Credits)
  Widget _buildDesktopLayout() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9), // Soft Warm Ivory Parchment
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Photo Card (Couple / Gym toggle)
          Expanded(
            flex: 4,
            child: _buildPhotoCard(isMobile: false),
          ),

          const SizedBox(width: 16),

          // Center: Bold "HE IS ⬅" Pointer with Animated Pulse
          _buildCenterPointer(isMobile: false),

          const SizedBox(width: 16),

          // Right: Movie End Credits Upward-Scrolling Pet Names with Descriptions
          Expanded(
            flex: 6,
            child: _buildMovieCreditsReel(height: 330, isMobile: false),
          ),
        ],
      ),
    );
  }

  /// Mobile Layout: Side-by-side with proportional sizing
  Widget _buildMobileLayout() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9), // Soft Warm Ivory Parchment
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.30),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Photo Card
          Expanded(
            flex: 5,
            child: _buildPhotoCard(isMobile: true),
          ),

          const SizedBox(width: 8),

          // Center: Compact "HE IS ⬅"
          _buildCenterPointer(isMobile: true),

          const SizedBox(width: 8),

          // Right: Movie Credits Reel
          Expanded(
            flex: 6,
            child: _buildMovieCreditsReel(height: 250, isMobile: true),
          ),
        ],
      ),
    );
  }

  /// Photo Card with Selvakumar Couple Car photo (and Gym toggle)
  Widget _buildPhotoCard({required bool isMobile}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showCoupleCarPhoto = !_showCoupleCarPhoto;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: isMobile ? 220 : 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
                width: 1.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8B1220).withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.20),
                  blurRadius: 14,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    _showCoupleCarPhoto
                        ? "assets/photos/who_is_he_couple_car.jpg"
                        : "assets/photos/selvakumar_gym.png",
                    fit: BoxFit.cover,
                    cacheWidth: 500,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/photos/selvakumar_gym.png",
                        fit: BoxFit.cover,
                        cacheWidth: 500,
                        alignment: Alignment.topCenter,
                      );
                    },
                  ),

                  // Subtle Bottom Gradient Scrim
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 64,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            const Color(0xFF2C1820).withValues(alpha: 0.45),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // Top Pill: Tap to switch indicator
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
                          width: 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.touch_app_rounded, size: 9, color: Color(0xFF8B1220)),
                          const SizedBox(width: 3),
                          Text(
                            _showCoupleCarPhoto ? "Couple ♡" : "Gym 💪",
                            style: GoogleFonts.outfit(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8B1220),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Corner Tag Badge
                  Positioned(
                    bottom: 8,
                    left: 6,
                    right: 6,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.94),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFD4AF37),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.10),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "SELVAKUMAR • 100% MINE ♡",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isMobile ? 8 : 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                              color: const Color(0xFF8B1220),
                            ),
                          ),
                        ),
                      ),
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

  /// Center Pointer: Bold "HE IS" + Left Arrow
  Widget _buildCenterPointer({required bool isMobile}) {
    return AnimatedBuilder(
      animation: _arrowPulseController,
      builder: (context, child) {
        final scale = 0.94 + (_arrowPulseController.value * 0.12);

        return Transform.scale(
          scale: scale,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "HE IS",
                style: GoogleFonts.cinzel(
                  fontSize: isMobile ? 12 : 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isMobile ? 1.5 : 2.5,
                  color: const Color(0xFF8B1220), // Royal Burgundy
                  shadows: [
                    Shadow(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              CustomPaint(
                size: Size(isMobile ? 22 : 36, isMobile ? 16 : 24),
                painter: _LeftArrowPainter(),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Movie End Credits Upward-Scrolling 100 Pet Names with Descriptions
  Widget _buildMovieCreditsReel({
    required double height,
    required bool isMobile,
  }) {
    final totalCycleCount = _petNames.length;
    final totalCycleHeight = totalCycleCount * _itemHeight;

    return RepaintBoundary(
      child: Container(
        height: height,
        decoration: BoxDecoration(
        color: const Color(0xFFF9F6F0).withValues(alpha: 0.90), // Soft Ivory Frosted Reel
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.white,
              Colors.white,
              Colors.transparent,
            ],
            stops: [0.0, 0.14, 0.86, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            final scrollOffset = (_scrollController.value * totalCycleHeight) % totalCycleHeight;

            return ClipRect(
              child: OverflowBox(
                minHeight: 0,
                maxHeight: double.infinity,
                alignment: Alignment.topCenter,
                child: Transform.translate(
                  offset: Offset(0, -scrollOffset),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_petNames.length * 3, (index) {
                      final nameIndex = index % _petNames.length;
                      final credit = _petNames[nameIndex];
                      final isHighlighted = _selectedNameIndex == nameIndex;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedNameIndex = nameIndex;
                          });
                          _triggerHearts(credit.title);
                        },
                        child: Container(
                          height: _itemHeight,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 8 : 16,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? const Color(0xFFFFF3CD).withValues(alpha: 0.75)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "•",
                                      style: TextStyle(
                                        color: isHighlighted
                                            ? const Color(0xFFC59B27)
                                            : const Color(0xFFC2185B),
                                        fontSize: isMobile ? 12 : 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      credit.title,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: isMobile ? 12.5 : 15,
                                        fontWeight: isHighlighted
                                            ? FontWeight.w900
                                            : FontWeight.w800,
                                        letterSpacing: 0.3,
                                        color: isHighlighted
                                            ? const Color(0xFF8B1220)
                                            : const Color(0xFF2C1820),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    credit.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.cormorantGaramond(
                                      fontSize: isMobile ? 12 : 14,
                                      fontStyle: FontStyle.italic,
                                      height: 1.2,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF4A342B), // Crisp, readable warm espresso
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

  /// Bottom Controls Bar: Pause/Resume Toggle + 100 Pet Names Counter Badge
  Widget _buildBottomBar(bool isMobile) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        // Play / Pause Reel Button
        InkWell(
          onTap: _togglePause,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F2EB),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.5),
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                  size: 14,
                  color: const Color(0xFF4A2835),
                ),
                const SizedBox(width: 5),
                Text(
                  _isPaused ? "Auto-Play" : "Pause Auto-Scroll",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 10 : 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4A2835),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Lifetime 100 Pet Names Count Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECEE),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE57373).withValues(alpha: 0.5),
              width: 1.0,
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("❤️", style: TextStyle(fontSize: 11)),
                const SizedBox(width: 6),
                Text(
                  "100 PET NAMES & SWEET MEANINGS FOREVER ♡",
                  style: AppTheme.monoStyle(
                    fontSize: isMobile ? 8 : 9.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8B1220),
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Authentic 35mm Cinema Film Perforations Sprocket Strip
  Widget _buildFilmPerforations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          14,
          (i) => Container(
            width: 14,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
                width: 0.6,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Left Arrow Painter for "HE IS ⬅"
class _LeftArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC59B27)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.4)
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final midY = size.height / 2;

    // Arrow line pointing left
    path.moveTo(size.width, midY);
    path.lineTo(4, midY);

    // Arrow head pointing left
    path.moveTo(size.height * 0.5, midY - (size.height * 0.45));
    path.lineTo(3, midY);
    path.lineTo(size.height * 0.5, midY + (size.height * 0.45));

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Floating heart for the interactive burst
class _FloatingHeart {
  double x;
  double y;
  double vx;
  double vy;
  String text;
  double size;
  double opacity = 1.0;

  _FloatingHeart({
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
    vy += 0.12; // Gentle gravity
    opacity = (opacity - 0.02).clamp(0.0, 1.0);
  }
}
