import '../models/book.dart';

/// 模拟书籍数据（20条起步，支持分页追加）
class BooksData {
  /// 基础数据：20本
  static final List<Book> baseBooks = List.generate(20, (i) {
    final categories = ['文学', '科技', '历史', '艺术', '哲学'];
    final titles = [
      '代码整洁之道', '算法导论', '深入理解计算机系统', '设计模式', '重构',
      'Flutter实战', 'Dart语言详解', '人工智能简史', '机器学习', '深度学习',
      '红楼梦', '西游记', '三国演义', '水浒传', '围城',
      '万历十五年', '人类简史', '未来简史', '今日简史', '苏菲的世界',
    ];
    final authors = [
      'Robert C. Martin', 'Thomas H. Cormen', 'Randal E. Bryant', 'Erich Gamma', 'Martin Fowler',
      '杜文', 'Gilad Bracha', 'Stuart Russell', '周志华', 'Ian Goodfellow',
      '曹雪芹', '吴承恩', '罗贯中', '施耐庵', '钱钟书',
      '黄仁宇', '尤瓦尔·赫拉利', '尤瓦尔·赫拉利', '尤瓦尔·赫拉利', '乔斯坦·贾德',
    ];
    return Book(
      id: i + 1,
      title: titles[i],
      author: authors[i],
      category: categories[i % categories.length],
      cover: 'https://picsum.photos/seed/book${i + 1}/200/300',
      description:
          '《${titles[i]}》由${authors[i]}所著，属于${categories[i % categories.length]}类图书。本书内容详实，适合各层次读者阅读学习，是一本值得反复品读的佳作。',
      borrowCount: 50 + (i * 7) % 200,
      rating: 3.5 + (i % 15) / 10.0,
    );
  });

  /// 分类列表（首页网格用）
  static const List<String> categories = ['全部', '文学', '科技', '历史', '艺术', '哲学'];

  /// 生成"加载更多"的追加数据
  /// [startId] 起始 id，[count] 追加条数
  static List<Book> generateMore(int startId, int count) {
    return List.generate(count, (i) {
      final idx = startId + i;
      final categories = ['文学', '科技', '历史', '艺术', '哲学'];
      return Book(
        id: idx,
        title: '扩展书籍 $idx',
        author: '作者 ${idx % 10}',
        category: categories[idx % categories.length],
        cover: 'https://picsum.photos/seed/ext$idx/200/300',
        description: '这是第 $idx 本扩展书籍的简介，用于演示分页加载更多功能。',
        borrowCount: 10 + (idx * 3) % 100,
        rating: 3.0 + (idx % 20) / 10.0,
      );
    });
  }
}
