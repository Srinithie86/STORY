import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_love_story/widgets/nav_bar.dart';
import 'package:our_love_story/widgets/story_hero.dart';
import 'package:our_love_story/widgets/story_transition.dart';
import 'package:our_love_story/widgets/friendship_story.dart';
import 'package:our_love_story/widgets/newspaper_falling_for_you.dart';
import 'package:our_love_story/widgets/fight_and_love_pledge.dart';
import 'package:our_love_story/widgets/memory_archive.dart';
import 'package:our_love_story/widgets/film_strip.dart';
import 'package:our_love_story/widgets/photo_collage.dart';
import 'package:our_love_story/widgets/music_player.dart';
import 'package:our_love_story/widgets/love_letter.dart';
import 'package:our_love_story/widgets/story_timeline.dart';
import 'package:our_love_story/widgets/birthday_reveal.dart';
import 'package:our_love_story/widgets/forever_archive.dart';
import 'package:our_love_story/widgets/final_reveal.dart';
import 'package:our_love_story/widgets/kitten_delivery_service.dart';
import 'package:our_love_story/widgets/birthday_car_track.dart';
import 'package:our_love_story/widgets/who_is_he_movie_credits.dart';
import 'package:our_love_story/widgets/congratulation_card.dart';
import 'package:our_love_story/widgets/romantic_flower_greeting_card.dart';
import 'package:our_love_story/widgets/interactive_envelope.dart';
import 'package:our_love_story/widgets/boyfriend_birthday_calendar_hero.dart';

void main() {
  const mobileSizes = [
    Size(320, 568), // Very narrow phone (iPhone SE 1)
    Size(360, 740), // Standard Android phone (Samsung Galaxy)
    Size(375, 667), // iPhone 8 / SE 2020
    Size(390, 844), // iPhone 13/14
    Size(412, 915), // Pixel 7
  ];

  for (final size in mobileSizes) {
    testWidgets('Zero overflow verification for all widgets at ${size.width}x${size.height}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final widgetsToTest = <String, Widget>{
        'NavBar': NavBar(onNavSelected: (_) {}, onOpenSecret: () {}),
        'StoryHero': StoryHero(onOpenStory: () {}),
        'StoryTransition': const StoryTransition(),
        'FriendshipStory': const FriendshipStory(),
        'NewspaperFallingForYouSection': const NewspaperFallingForYouSection(),
        'FightAndLovePledgeSection': const FightAndLovePledgeSection(),
        'MemoryArchive': MemoryArchive(),
        'FilmStrip': FilmStrip(),
        'PhotoCollage': const PhotoCollage(),
        'MusicPlayerSection': const MusicPlayerSection(),
        'LoveLetterSection': LoveLetterSection(),
        'StoryTimeline': StoryTimeline(),
        'BirthdayRevealSection': const BirthdayRevealSection(),
        'InteractiveCakeCuttingWidget': const InteractiveCakeCuttingWidget(),
        'BoyfriendBirthdayCalendarHero': const BoyfriendBirthdayCalendarHero(),
        'ForeverArchiveSection': ForeverArchiveSection(),
        'WhoIsHeMovieCreditsSection': const WhoIsHeMovieCreditsSection(),
        'KittenDeliveryService': const KittenDeliveryService(isMobile: true),
        'BirthdayCarTrackCard': const BirthdayCarTrackCard(),
        'CongratulationCard': const CongratulationCard(),
        'RomanticFlowerGreetingCard': const RomanticFlowerGreetingCard(),
        'InteractiveEnvelope': InteractiveEnvelope(onOpen: () {}, isOpen: false),
        'FinalRevealSection': const FinalRevealSection(),
      };

      for (final entry in widgetsToTest.entries) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: entry.value,
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 200));
        final ex = tester.takeException();
        if (ex != null) {
          debugPrint('>>> OVERFLOW IN ${entry.key}: $ex');
        }
        expect(ex, isNull, reason: '${entry.key} overflowed at ${size.width}x${size.height}');
      }
    });
  }
}
