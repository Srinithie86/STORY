import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/story_hero.dart';
import '../widgets/story_transition.dart';
import '../widgets/friendship_story.dart';
import '../widgets/newspaper_falling_for_you.dart';
import '../widgets/fight_and_love_pledge.dart';
import '../widgets/memory_archive.dart';
import '../widgets/film_strip.dart';
import '../widgets/photo_collage.dart';
import '../widgets/music_player.dart';
import '../widgets/love_letter.dart';
import '../widgets/story_timeline.dart';
import '../widgets/birthday_reveal.dart';
import '../widgets/forever_archive.dart';
import '../widgets/final_reveal.dart';
import '../widgets/paper_texture_overlay.dart';
import '../widgets/background_video_player.dart';
import '../widgets/our_video_section.dart';
import 'secret_memory_page.dart';

class StoryHomePage extends StatefulWidget {
  const StoryHomePage({super.key});

  @override
  State<StoryHomePage> createState() => _StoryHomePageState();
}

class _StoryHomePageState extends State<StoryHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _storyKey = GlobalKey();
  final GlobalKey _archiveKey = GlobalKey();
  final GlobalKey _filmKey = GlobalKey();
  final GlobalKey _letterKey = GlobalKey();
  final GlobalKey _timelineKey = GlobalKey();
  final GlobalKey _foreverKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Background precache after UI has already rendered on screen
      for (final path in [
        'assets/photos/who_is_he_couple_car.jpg',
        'assets/photos/birthday_kitten.jpg',
        'assets/photos/party_cat.jpg',
      ]) {
        try {
          precacheImage(AssetImage(path), context);
        } catch (_) {}
      }
    });
  }

  void _scrollToSection(String sectionKey) {
    GlobalKey? targetKey;
    switch (sectionKey) {
      case "story":
        targetKey = _storyKey;
        break;
      case "archive":
        targetKey = _archiveKey;
        break;
      case "film":
        targetKey = _filmKey;
        break;
      case "letter":
        targetKey = _letterKey;
        break;
      case "timeline":
        targetKey = _timelineKey;
        break;
      case "forever":
        targetKey = _foreverKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openSecretPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SecretMemoryPage()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackgroundVideoPlayer(
        videoPaths: const [
          "assets/videos/video_01.mp4",
          "assets/videos/video_02.mp4",
        ],
        overlayOpacity: 0.12,
        child: PaperTextureOverlay(
          child: Column(
            children: [
              // Top Navigation Bar
              NavBar(
                onNavSelected: _scrollToSection,
                onOpenSecret: _openSecretPage,
              ),

              // Scrollable Story Sections
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    children: [
                      // 01 — INTRO / HERO
                      RepaintBoundary(
                        child: StoryHero(
                          key: _storyKey,
                          onOpenStory: () => _scrollToSection("archive"),
                        ),
                      ),

                      // 02 — STORY TRANSITION (Dark Charcoal)
                      const RepaintBoundary(child: StoryTransition()),

                      // 03 — FRIENDSHIP TO LOVE PROGRESSION
                      const RepaintBoundary(child: FriendshipStory()),

                      // 03.2 — THE BROADSHEET NEWSPAPER: FALLING FOR YOU 📰
                      const RepaintBoundary(child: NewspaperFallingForYouSection()),

                      // 03.5 — 10,000+ FIGHTS & STILL I CHOOSE YOU PLEDGE 🥊
                      const RepaintBoundary(child: FightAndLovePledgeSection()),

                      // 04 — MEMORY ARCHIVE
                      RepaintBoundary(child: MemoryArchive(key: _archiveKey)),

                      // 05 — THE FILM
                      RepaintBoundary(child: FilmStrip(key: _filmKey)),

                      // 06 — PHOTO COLLAGE
                      const RepaintBoundary(child: PhotoCollage()),

                      // 07 — OUR VIDEO REELS 🎥
                      const RepaintBoundary(child: OurVideoSection()),

                      // 08 — OUR SONG ♫
                      const RepaintBoundary(child: MusicPlayerSection()),

                      // 09 — LOVE LETTER
                      RepaintBoundary(child: LoveLetterSection(key: _letterKey)),

                      // 10 — OUR TIMELINE
                      RepaintBoundary(child: StoryTimeline(key: _timelineKey)),

                      // 11 — BIRTHDAY REVEAL
                      const RepaintBoundary(child: BirthdayRevealSection()),

                      // 12 — FOREVER ARCHIVE
                      RepaintBoundary(child: ForeverArchiveSection(key: _foreverKey)),

                      // 13 — FINAL REVEAL & FOOTER
                      const RepaintBoundary(child: FinalRevealSection()),
                    ],
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
