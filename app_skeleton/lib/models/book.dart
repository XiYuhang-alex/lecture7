/// Book 数据模型
/// 用于列表展示与详情页传参（强类型模型，避免使用 Map）
class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final String cover;
  final String description;
  final int borrowCount;
  final double rating;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.cover,
    required this.description,
    required this.borrowCount,
    required this.rating,
  });

  /// 从 JSON Map 构造（用于 assets/books.json）
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      category: json['category'] as String,
      cover: json['cover'] as String,
      description: json['description'] as String,
      borrowCount: json['borrowCount'] as int,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'category': category,
        'cover': cover,
        'description': description,
        'borrowCount': borrowCount,
        'rating': rating,
      };
}
