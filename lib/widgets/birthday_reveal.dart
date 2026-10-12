import 'package:flutter/material.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'congratulation_card.dart';
import 'birthday_car_track.dart';
import 'romantic_flower_greeting_card.dart';
import 'birthday_bunting_banner.dart';

class BirthdayRevealSection extends StatefulWidget {
  const BirthdayRevealSection({super.key});

  @override
  State<BirthdayRevealSection> createState() => _BirthdayRevealSectionState();
}

class _BirthdayRevealSectionState extends State<BirthdayRevealSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeHeader;
  late Animation<double> _fadeMain;
  late Animation<double> _fadeMessage;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeHeader = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );
    _fadeMain = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
    );
    _fadeMessage = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 12 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 0. Festive Burgundy Birthday Bunting Banner Overlay
              FadeTransition(
                opacity: _fadeHeader,
                child: const BirthdayBuntingBanner(),
              ),

              // 1. Anticipation Subtitle
              FadeTransition(
                opacity: _fadeHeader,
                child: Text(
                  "there is one more thing...",
                  style: AppTheme.handwrittenStyle(
                    fontSize: isMobile ? 24 : 30,
                    color: AppTheme.deepBurgundy,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              FadeTransition(
                opacity: _fadeHeader,
                child: Text(
                  StoryConfig.birthdaySubheader,
                  style: AppTheme.monoStyle(
                    fontSize: 12,
                    letterSpacing: 2.0,
                    color: AppTheme.darkCharcoal,
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // 2. CONGRATULATION Card

              FadeTransition(
                opacity: _fadeMain,
                child: const CongratulationCard(),
              ),
              const SizedBox(height: 48),

              // 2.5 Interactive Happy Birthday Mani Car Track Loop Card
              FadeTransition(
                opacity: _fadeMain,
                child: const BirthdayCarTrackCard(),
              ),
              const SizedBox(height: 48),

              // 3. Premium Interactive Floral Birthday Greeting Card ("Flowers For You, My Sweetheart")
              FadeTransition(
                opacity: _fadeMain,
                child: const RomanticFlowerGreetingCard(),
              ),
              const SizedBox(height: 48),

              // 4. Birthday Personal Note
              FadeTransition(
                opacity: _fadeMessage,
                child: Text(
                  "“${StoryConfig.birthdayMessage}”",
                  textAlign: TextAlign.center,
                  style: AppTheme.serifStyle(
                    fontSize: isMobile ? 20 : 24,
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFFFDFBF7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
