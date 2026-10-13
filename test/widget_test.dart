import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_love_story/widgets/kitten_delivery_service.dart';
import 'package:our_love_story/widgets/love_letter.dart';
import 'package:our_love_story/widgets/who_is_he_movie_credits.dart';
import 'package:our_love_story/widgets/birthday_car_track.dart';
import 'package:our_love_story/widgets/congratulation_card.dart';
import 'package:our_love_story/widgets/fight_and_love_pledge.dart';
import 'package:our_love_story/widgets/romantic_flower_greeting_card.dart';
import 'package:our_love_story/widgets/forever_archive.dart';
import 'package:our_love_story/widgets/boyfriend_birthday_calendar_hero.dart';
import 'package:our_love_story/widgets/final_reveal.dart';

void main() {
  testWidgets('KittenDeliveryService renders and interacts cleanly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: KittenDeliveryService(isMobile: false),
          ),
        ),
      ),
    );

    // Verify header and couriers
    expect(find.text('PAW EXPRESS'), findsOneWidget);
    expect(find.text('Luna 🎀'), findsOneWidget);
    expect(find.text('Turbo 🏎️'), findsOneWidget);

    // Accept delivery interaction
    final acceptButton = find.text('Accept Flower Delivery 🌸');
    expect(acceptButton, findsOneWidget);

    await tester.ensureVisible(acceptButton);
    await tester.tap(acceptButton);
    await tester.pump(const Duration(milliseconds: 600));

    // Verify delivered state
    expect(find.text('CERTIFIED DELIVERED'), findsOneWidget);
    expect(find.text('Next Courier ➔'), findsOneWidget);
  });

  testWidgets('LoveLetterSection renders envelope and opens/folds cleanly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LoveLetterSection(),
          ),
        ),
      ),
    );

    // Initially closed: envelope button & hint visible
    expect(find.text('Unfold Love Letter'), findsOneWidget);
    expect(find.text('Tap the envelope to open the letter 💌'), findsOneWidget);
    expect(find.text('My Dearest Love,'), findsNothing);

    // Tap to unfold love letter
    final unfoldButton = find.text('Unfold Love Letter');
    await tester.ensureVisible(unfoldButton);
    await tester.tap(unfoldButton);
    await tester.pump(const Duration(milliseconds: 800));

    // Opened state
    expect(find.text('My Dearest Love,'), findsOneWidget);
    expect(find.text('Fold Back into Envelope'), findsOneWidget);

    // Tap to fold back into envelope
    final foldButton = find.text('Fold Back into Envelope');
    await tester.ensureVisible(foldButton);
    await tester.tap(foldButton);
    await tester.pump(const Duration(milliseconds: 800));

    // Resealed state
    expect(find.text('Unfold Love Letter'), findsOneWidget);
  });

  testWidgets('WhoIsHeMovieCreditsSection renders movie reel with pet names', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: WhoIsHeMovieCreditsSection(),
          ),
        ),
      ),
    );

    // Verify title and HE IS
    expect(find.text('“WHO IS HE?”'), findsOneWidget);
    expect(find.text('HE IS'), findsOneWidget);
    expect(find.text('SELVAKUMAR • 100% MINE ♡'), findsOneWidget);
    expect(find.text('my pookie'), findsWidgets);
    expect(find.text('Pause Auto-Scroll'), findsOneWidget);

    // Toggle pause/play
    final pauseButton = find.text('Pause Auto-Scroll');
    await tester.tap(pauseButton);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Auto-Play'), findsOneWidget);
  });

  testWidgets('BirthdayCarTrackCard renders and navigates loop coaster', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: BirthdayCarTrackCard(),
          ),
        ),
      ),
    );

    // Initial slide: Happy 25th Birthday
    expect(find.text('Happy 25th Birthday'), findsOneWidget);
    expect(find.byIcon(Icons.directions_car_rounded), findsOneWidget);
    expect(find.byIcon(Icons.volume_down_rounded), findsOneWidget);

    // Honk button interaction
    await tester.tap(find.byIcon(Icons.volume_down_rounded));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('HONK • MANI ❤️'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 500));

    // Toggle car color
    await tester.tap(find.byIcon(Icons.directions_car_rounded));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byIcon(Icons.directions_car_rounded), findsOneWidget);
  });

  testWidgets('CongratulationCard handles NO to how dare you cleanly with zero overflows', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: CongratulationCard(),
          ),
        ),
      ),
    );

    // Initial Screen
    expect(find.text('Happy birthday, love!'), findsOneWidget);
    expect(find.text('NO'), findsOneWidget);

    // Tap NO
    await tester.tap(find.text('NO'));
    await tester.pump(const Duration(milliseconds: 400));

    // Screen 1: "how dare you???"
    expect(find.text('how dare you???'), findsOneWidget);
    expect(find.text('TRY AGAIN'), findsOneWidget);

    // Tap TRY AGAIN
    await tester.tap(find.text('TRY AGAIN'));
    await tester.pump(const Duration(milliseconds: 400));

    // Back to question
    expect(find.text('Happy birthday, love!'), findsOneWidget);
  });

  testWidgets('FightAndLovePledgeSection renders fights and pledges cleanly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: FightAndLovePledgeSection(),
          ),
        ),
      ),
    );

    // Verify header
    expect(find.textContaining('10,000+ SILLY FIGHTS'), findsOneWidget);
    expect(find.text('“I want to daily fight with you, for the rest of my life!” ♡'), findsOneWidget);

    // Tap on first fight reason to expand
    final reasonFinder = find.textContaining('The 3-Minute Crisis');
    await tester.ensureVisible(reasonFinder);
    await tester.tap(reasonFinder);
    await tester.pump(const Duration(milliseconds: 500));

    // Verify expanded details
    expect(find.textContaining('fake breakup #482'), findsOneWidget);

    // Verify Life Contract & Promises section
    expect(find.textContaining('L I F E   C O N T R A C T'), findsOneWidget);
  });

  testWidgets('RomanticFlowerGreetingCard renders bouquet and allows card flipping', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: RomanticFlowerGreetingCard(),
          ),
        ),
      ),
    );

    // Wait for entrance animation
    await tester.pump(const Duration(milliseconds: 1200));

    // Verify initial closed card hint & replay
    expect(find.text('Tap card to open message ♡'), findsOneWidget);
    expect(find.text('Replay'), findsOneWidget);

    // Tap to open card
    final cardHint = find.text('Tap card to open message ♡');
    await tester.ensureVisible(cardHint);
    await tester.tap(cardHint);
    await tester.pump(const Duration(milliseconds: 800));

    // Verify opened card state
    expect(find.text('Tap to close card'), findsOneWidget);
  });

  testWidgets('InteractiveCakeCuttingWidget allows candle blowing and slice cutting', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: InteractiveCakeCuttingWidget(),
          ),
        ),
      ),
    );

    // Verify title and actions
    expect(find.text('“Make a Wish & Cut the First Slice”'), findsOneWidget);
    expect(find.text('BLOW CANDLES 💨'), findsOneWidget);
    expect(find.text('CUT FIRST SLICE 🎂'), findsOneWidget);

    // Blow candles
    final blowBtn = find.text('BLOW CANDLES 💨');
    await tester.ensureVisible(blowBtn);
    await tester.tap(blowBtn);
    await tester.pump(const Duration(milliseconds: 700));

    // Candles blown state
    expect(find.text('RELIGHT CANDLES 🔥'), findsOneWidget);

    // Cut cake slice
    final cutBtn = find.text('CUT FIRST SLICE 🎂');
    await tester.ensureVisible(cutBtn);
    await tester.tap(cutBtn);
    await tester.pump(const Duration(milliseconds: 900));

    // Celebration message revealed in-place without modal covering cake
    expect(find.text('🎉 🎂 🎉'), findsOneWidget);
    expect(find.text('REPLAY SLICE 🍰'), findsOneWidget);

    // Drain SnackBar & celebration timers
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('BoyfriendBirthdayCalendarHero navigates months and displays memories', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: BoyfriendBirthdayCalendarHero(),
          ),
        ),
      ),
    );

    // Initial Month: October 2026
    expect(find.text('~ October ~'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);
    expect(find.text("OCTOBER 13 · SELVAKUMAR'S 24TH BIRTHDAY"), findsOneWidget);

    // Navigate to previous month
    final prevBtn = find.byTooltip('Previous Month');
    await tester.ensureVisible(prevBtn);
    await tester.tap(prevBtn);
    await tester.pump(const Duration(milliseconds: 400));

    // September 2026
    expect(find.text('~ September ~'), findsOneWidget);
    expect(find.text('Jump to Oct 13 Birthday'), findsOneWidget);

    // Jump back to Oct 13 Birthday
    final jumpBtn = find.text('Jump to Oct 13 Birthday');
    await tester.tap(jumpBtn);
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('~ October ~'), findsOneWidget);

    // Drain floating kisses timer
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('FinalRevealSection renders diploma, cinematic movie end card and replays story', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    bool replayFired = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: FinalRevealSection(
              onReplayStory: () {
                replayFired = true;
              },
            ),
          ),
        ),
      ),
    );

    // Verify diploma certificate
    expect(find.text('BEST BOYFRIEND'), findsOneWidget);
    expect(find.text('IN THE WORLD'), findsOneWidget);

    // Verify cinematic movie end card
    expect(find.text('THE FINAL SCENE · A LIFETIME PRODUCTION'), findsOneWidget);
    expect(find.text('~ The End ~'), findsOneWidget);
    expect(find.text('REPLAY OUR STORY ↺'), findsOneWidget);

    // Tap Replay button
    final replayBtn = find.text('REPLAY OUR STORY ↺');
    await tester.ensureVisible(replayBtn);
    await tester.tap(replayBtn);
    await tester.pump(const Duration(milliseconds: 200));

    expect(replayFired, isTrue);
  });
}

