import 'package:flutter/material.dart';
import '../data/books_data.dart';
import '../widgets/category_card.dart';

/// 首页：GridView 分类入口
/// 点击分类 → 列表页（按类别过滤）
/// 接收列表页回传的过滤值，显示在 AppBar 副标题
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 列表页回传的过滤结果
  String _filterResult = '暂无筛选';

  /// 各分类图标映射
  static const Map<String, IconData> _categoryIcons = {
    '全部': Icons.auto_stories,
    '文学': Icons.menu_book,
    '科技': Icons.science,
    '历史': Icons.history_edu,
    '艺术': Icons.palette,
    '哲学': Icons.psychology,
  };

  /// 统计各分类书籍数量
  int _countByCategory(String category) {
    if (category == '全部') return BooksData.baseBooks.length;
    return BooksData.baseBooks
        .where((b) => b.category == category)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('图书管理系统'),
            Text(
              '筛选：$_filterResult',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          // 独立研究入口：CustomScrollView + Sliver
          IconButton(
            icon: const Icon(Icons.view_module),
            tooltip: 'Sliver 实验',
            onPressed: () => Navigator.pushNamed(context, '/sliver'),
          ),
          // 独立研究入口：路由守卫（登录）
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: '登录页（路由守卫）',
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
          // 独立研究入口：自定义转场
          IconButton(
            icon: const Icon(Icons.animation),
            tooltip: '自定义转场',
            onPressed: () => Navigator.pushNamed(context, '/transition'),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: BooksData.categories.length,
        itemBuilder: (context, i) {
          final cat = BooksData.categories[i];
          return CategoryCard(
            category: cat,
            icon: _categoryIcons[cat] ?? Icons.category,
            count: _countByCategory(cat),
            onTap: () async {
              // 跳列表页并按类别过滤；await 接收回传值
              final result = await Navigator.pushNamed(
                context,
                '/list',
                arguments: cat,
              );
              if (result != null && mounted) {
                setState(() {
                  _filterResult = result as String;
                });
              }
            },
          );
        },
      ),
    );
  }
}
