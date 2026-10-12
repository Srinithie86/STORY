import '../models/memory.dart';
import '../models/story_chapter.dart';
import '../models/year_archive.dart';

class StoryConfig {
  // Names
  static const String girlName = "Srinithi";
  static const String boyName = "Selvakumar";

  // Key Dates
  static const String storyStartDate = "2022";
  static const String friendshipDate = "08 . 14 . 2022";
  static const String loveDate = "02 . 14 . 2024";
  static const String birthdayDate = "10 . 13 . 2026";

  // Hero Text
  static const String openingQuestion = "what does love mean?";
  static const String openingAnswer = "maybe… it is you 🌻";
  static const String openingNote = "like a sunflower turning to the sun, my heart chooses you.";

  // Song Details
  static const String songTitle = "Un Kaiyil En Peyar 🎵";
  static const String songArtist = "Selvakumar & Srinithi ♡";
  static const String songPath = "assets/music/Un_Kaiyil_En_Peyar.mp3";

  // Birthday Reveal
  static const String birthdayTitle = "HAPPY BIRTHDAY, MY SUNFLOWER 🌻";
  static const String birthdaySubheader = "today is full of sunshine, just like you.";
  static const String birthdayMessage = 
      "Happy Birthday to the person who brings bright sunshine into my world every single day. Thank you for your warmth, your laughter, and for being my favorite part of life.";

  // Final Reveal
  static const String finalQuestion = "IF I COULD GO BACK TO THE BEGINNING…";
  static const String finalAnswer = "I would choose you, in every life 🌻";
  static const String finalTagline = "from best friends, to forever love 🌻";
  static const String finalFooterText = "come back here whenever you want to remember our story.";

  // Love Letter
  static const String loveLetter = '''
Happy Birthday to my favourite person, my best friend, and my love. 💖❤️

Sometimes I wonder how beautifully life works. You came into my life as a friend, but slowly, without me even realising it, you became someone so special to my heart. Somewhere between our conversations, our silly fights, our laughs, and our little moments, I started falling for you. And today, you are not just my love; you are a beautiful part of my life that I never want to lose. 🥹💗

You were my friend before you became my love, and that will always be my favourite part of our story. ❤️

I love the little things about us — the random conversations, the way we make each other smile, the silly moments nobody else would understand, and the memories that might look ordinary to others but mean everything to me.

I don't know what the future has planned for us, but I know one thing: I want to create more memories with you. More birthdays, more laughter, more adventures, more late-night talks, more silly fights that end with smiles, and more beautiful moments that we can look back on someday. 🤍❤️

On your birthday, I wish you all the happiness your heart can hold. May your dreams come true, may you achieve everything you work for, and may life always give you reasons to smile. Whenever life gets difficult, I hope you remember that someone is always cheering for you, believing in you, and wishing the very best for you. 💌

If I could go back to the beginning, knowing everything I know today, I would still choose to be your friend… and I would still fall in love with you all over again. ♾️❤️

You are one of my favourite chapters, my sweetest surprise, and a memory I want to keep creating for a lifetime.

Happy Birthday, my love. 🎂❤️

Here's to you, to me, to the friendship that became love, and to the beautiful story we are still writing together.

I love you — today, tomorrow, and in all the little moments that make our story ours. ❤️🧿

Forever your girl,  
the friend who fell in love with you. 💋
''';

  // Secret Memories (accessible via /secret or hidden trigger)
  static const List<String> secretNotes = [
    "10,000+ fights, endless breakups, still I choose you! I want to daily fight with u forever! 🥊❤️",
    "I fell in love with your laugh long before I admitted it to myself over a cup of kaapi.",
    "The exact evening I realized you were my soulmate was during our sunset conversation.",
    "I still keep every little note, photo, and sweet message from our earliest days.",
    "No matter how many years pass, my heart will always choose you, in every lifetime 🪷"
  ];

  // Memories Archive List
  static const List<Memory> memories = [
    Memory(
      id: "001",
      date: "08 . 14 . 2022",
      title: "WALKING BY THE WAVES 🌊",
      caption: "Holding hands where the gentle ocean waves touch our feet.",
      imagePath: "assets/photos/beach_walk.jpg",
      location: "Coastal Shoreline",
      year: "2022",
      category: "Love",
      handwrittenNote: "every step beside you feels like home...",
    ),
    Memory(
      id: "002",
      date: "09 . 22 . 2022",
      title: "LAUGHTER IN THE TIDE 🐚",
      caption: "Caught up in laughter, ocean breeze, and endless happiness.",
      imagePath: "assets/photos/beach_standing.jpg",
      location: "Shoreline Waves",
      year: "2022",
      category: "Moments",
      handwrittenNote: "your laughter is my favorite melody ♡",
    ),
    Memory(
      id: "003",
      date: "11 . 05 . 2023",
      title: "TRADITIONAL ROOTS 🪷",
      caption: "Dressed in veshti & saree, celebrating our culture & timeless love.",
      imagePath: "assets/photos/traditional_couple.jpg",
      location: "Heritage Courtyard",
      year: "2023",
      category: "Tradition",
      handwrittenNote: "pure South Indian elegance...",
    ),
    Memory(
      id: "004",
      date: "02 . 14 . 2024",
      title: "MATCHING TEES, MATCHING HEARTS 👫",
      caption: "Twinning in white tees under the clear blue sky.",
      imagePath: "assets/photos/matching_tees.jpg",
      location: "City Outing",
      year: "2024",
      category: "Moments",
      handwrittenNote: "twinning and winning at life together ♡",
    ),
    Memory(
      id: "005",
      date: "04 . 20 . 2024",
      title: "CELEBRATION NIGHT 🎉",
      caption: "Dressed up, smiling wide, celebrating love at a grand event.",
      imagePath: "assets/photos/event_together.jpg",
      location: "Grand Celebration Hall",
      year: "2024",
      category: "Celebrations",
      handwrittenNote: "my forever plus-one...",
    ),
    Memory(
      id: "006",
      date: "06 . 18 . 2024",
      title: "TEMPLE BLESSINGS 🛕",
      caption: "Seeking divine blessings together at the sacred temple.",
      imagePath: "assets/photos/temple_visit.jpg",
      location: "Velayudhaswami Temple",
      year: "2024",
      category: "Spiritual",
      handwrittenNote: "praying for our forever...",
    ),
    Memory(
      id: "007",
      date: "08 . 12 . 2024",
      title: "FRANGIPANI GLANCES 🌺",
      caption: "A stolen glance, a flower in her hair, and all the love in the world.",
      imagePath: "assets/photos/garden_flower_01.jpg",
      location: "Garden Paradise",
      year: "2024",
      category: "Candid",
      handwrittenNote: "the way he looks at me...",
    ),
    Memory(
      id: "008",
      date: "11 . 02 . 2024",
      title: "HIS SMILE, MY WORLD 😊",
      caption: "That smile that makes everything else fade away.",
      imagePath: "assets/photos/garden_flower_02.jpg",
      location: "Garden Paradise",
      year: "2024",
      category: "Love",
      handwrittenNote: "his smile is my favourite view...",
    ),
    Memory(
      id: "009",
      date: "12 . 10 . 2024",
      title: "TOGETHER IN BLOOM 🌸",
      caption: "Two hearts blooming together among the blossoms.",
      imagePath: "assets/photos/garden_flower_03.jpg",
      location: "Garden Paradise",
      year: "2024",
      category: "Moments",
      handwrittenNote: "blooming together forever...",
    ),
    Memory(
      id: "010",
      date: "01 . 15 . 2025",
      title: "PROTECTIVE LOVE 💪",
      caption: "The one who shields me from the world with just one arm.",
      imagePath: "assets/photos/garden_flower_04.jpg",
      location: "Garden Paradise",
      year: "2025",
      category: "Love",
      handwrittenNote: "my safe place is beside you...",
    ),
    Memory(
      id: "011",
      date: "03 . 28 . 2025",
      title: "GARDEN SELFIE 📸",
      caption: "Just us, flowers, and a perfect moment captured forever.",
      imagePath: "assets/photos/garden_flower_05.jpg",
      location: "Garden Paradise",
      year: "2025",
      category: "Candid",
      handwrittenNote: "our little paradise...",
    ),
    Memory(
      id: "012",
      date: "10 . 15 . 2025",
      title: "GOLDEN HOUR GLOW 🌅",
      caption: "Watching the sunset paint the sky while standing together.",
      imagePath: "assets/photos/sunset_selfie.jpg",
      location: "Hilltop Sunset Point",
      year: "2025",
      category: "Adventures",
      handwrittenNote: "golden hour with my golden boy...",
    ),
    Memory(
      id: "013",
      date: "09 . 05 . 2026",
      title: "HILLTOP ADVENTURES 🏔️",
      caption: "Matching white tees, windswept hair, and endless smiles at the summit.",
      imagePath: "assets/photos/hilltop_selfie.jpg",
      location: "Mountain Viewpoint",
      year: "2026",
      category: "Adventures",
      handwrittenNote: "on top of the world with you...",
    ),
    Memory(
      id: "014",
      date: "09 . 06 . 2026",
      title: "OUR SHADOW STORY 🖤",
      caption: "Even our shadows hold hands — love that follows us everywhere.",
      imagePath: "assets/photos/shadow_love.jpg",
      location: "Roadside Moment",
      year: "2026",
      category: "Candid",
      handwrittenNote: "even our shadows are in love...",
    ),
    Memory(
      id: "015",
      date: "09 . 06 . 2026",
      title: "PINK FLOWERS FOR YOU 🌸",
      caption: "He picked a bouquet of pink flowers just for her.",
      imagePath: "assets/photos/pink_flowers.jpg",
      location: "Roadside Surprise",
      year: "2026",
      category: "Love",
      handwrittenNote: "flowers from his hands to mine...",
    ),
    Memory(
      id: "016",
      date: "09 . 20 . 2026",
      title: "BEACH BOY VIBES 🌊",
      caption: "Looking out into the waves, cool breeze and ocean serenity.",
      imagePath: "assets/photos/selvakumar_beach.png",
      location: "Coastal Sands",
      year: "2026",
      category: "Candid",
      handwrittenNote: "my handsome beach boy...",
    ),
  ];

  // Timeline Chapters
  static const List<StoryChapter> timelineChapters = [
    StoryChapter(
      stage: "THE BEGINNING · 2022",
      date: "AUGUST 2022",
      title: "THE ROAD WE WALK",
      description: "Where our journey started in 2022: two paths crossing quietly by the gentle sea breeze.",
      imagePath: "assets/photos/beach_walk.jpg",
      note: "two paths crossing quietly",
    ),
    StoryChapter(
      stage: "LAUGHTER & WAVES · 2023",
      date: "OCTOBER 2023",
      title: "LAUGHTER & WAVES",
      description: "Standing in the waves together, laughing with our whole hearts.",
      imagePath: "assets/photos/beach_standing.jpg",
      note: "laughter echoing across the tide",
    ),
    StoryChapter(
      stage: "TWINNING HEARTS · 2024",
      date: "DECEMBER 2023",
      title: "TWINNING IN WHITE",
      description: "Matching tees under the open sky, making memories every step.",
      imagePath: "assets/photos/matching_tees.jpg",
      note: "matching hearts, matching smiles",
    ),
    StoryChapter(
      stage: "CELEBRATION NIGHT · 2025",
      date: "FEBRUARY 2024",
      title: "CELEBRATION NIGHT",
      description: "Dressed up and celebrating milestones, smiling wide together.",
      imagePath: "assets/photos/event_together.jpg",
      note: "my forever plus-one",
    ),
    StoryChapter(
      stage: "TODAY & FOREVER · 2026",
      date: "OCTOBER 2026",
      title: "TRADITIONAL & TIMELESS",
      description: "Veshti and saree, rooted in tradition, wrapped in infinite love.",
      imagePath: "assets/photos/traditional_couple.jpg",
      note: "the rest of our lives",
    ),
  ];

  // Future Yearly Archives
  static final List<YearArchive> yearlyArchives = [
    YearArchive(
      year: "2026",
      title: "THE BIRTHDAY CHAPTER",
      description: "The year we turned our memories into an everlasting archive.",
      letter: "To 2026, the year of laughter and building our future side by side.",
      coverImage: "assets/photos/traditional_couple.jpg",
      memories: memories.sublist(0, 3),
    ),
    YearArchive(
      year: "2027",
      title: "NEW HORIZONS",
      description: "Adding new trips, new quiet mornings, and deeper love.",
      letter: "Every year with you is my new favorite year.",
      coverImage: "assets/photos/beach_standing.jpg",
      memories: memories.sublist(2, 5),
    ),
    YearArchive(
      year: "2028",
      title: "TIMLESS JOURNEY",
      description: "Five years of friendship, four years of love, forever to go.",
      letter: "Looking forward to growing old with my best friend.",
      coverImage: "assets/photos/beach_walk.jpg",
      memories: memories,
    ),
  ];
}
