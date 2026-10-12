import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'widgets/custom_cursor.dart';
import 'screens/story_home_page.dart';
import 'screens/secret_memory_page.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const OurLoveStoryApp());
}

class OurLoveStoryApp extends StatelessWidget {
  const OurLoveStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Our Story · Digital Memory Archive',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return CustomCursorWrapper(
          child: child ?? const SizedBox.shrink(),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const StoryHomePage(),
        '/secret': (context) => const SecretMemoryPage(),
      },
    );
  }
}
