
class StoryChapter {
  final String stage;
  final String date;
  final String title;
  final String description;
  final String? imagePath;
  final String? note;

  const StoryChapter({
    required this.stage,
    required this.date,
    required this.title,
    required this.description,
    this.imagePath,
    this.note,
  });
}
