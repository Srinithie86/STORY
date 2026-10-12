import 'memory.dart';

class YearArchive {
  final String year;
  final String title;
  final String description;
  final String letter;
  final String coverImage;
  final List<Memory> memories;

  const YearArchive({
    required this.year,
    required this.title,
    required this.description,
    required this.letter,
    required this.coverImage,
    required this.memories,
  });
}
