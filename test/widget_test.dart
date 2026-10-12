import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:our_love_story/widgets/kitten_delivery_service.dart';
import 'package:our_love_story/widgets/love_letter.dart';
import 'package:our_love_story/widgets/who_is_he_movie_credits.dart';
import 'package:our_love_story/widgets/birthday_car_track.dart';
import 'package:our_love_story/widgets/congratulation_card.dart';

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
}
