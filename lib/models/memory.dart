class Memory {
  final String id;
  final String date;
  final String title;
  final String caption;
  final String imagePath;
  final String? videoPath;
  final String location;
  final String year;
  final String category;
  final String? handwrittenNote;

  const Memory({
    required this.id,
    required this.date,
    required this.title,
    required this.caption,
    required this.imagePath,
    this.videoPath,
    required this.location,
    required this.year,
    required this.category,
    this.handwrittenNote,
  });
}
