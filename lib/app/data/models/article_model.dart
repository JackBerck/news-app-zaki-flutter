class Article {
  final String id;
  final String title;
  final String author;
  final String date;
  final String category;
  final String imageUrl;
  final String content;
  final bool isBookmarked;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.category,
    required this.imageUrl,
    required this.content,
    this.isBookmarked = false,
  });
}
