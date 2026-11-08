import 'package:flutter/material.dart';
import '../data/books_data.dart';

/// 独立研究任务1：CustomScrollView 与 Sliver 初探
/// 用 SliverGrid + SliverList 实现首页网格与列表同屏滚动
class SliverPage extends StatelessWidget {
  const SliverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final books = BooksData.baseBooks;
    final categories = BooksData.categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomScrollView + Sliver 实验'),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar：可折叠顶部
          const SliverAppBar(
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('图书分类与推荐'),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                ),
              ),
            ),
            pinned: true,
          ),
          // SliverGrid：分类网格
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final cat = categories[i];
                return Card(
                  child: Center(
                    child: Text(
                      cat,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
              childCount: categories.length,
            ),
          ),
          // SliverToBoxAdapter：分隔标题
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                '推荐书籍',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // SliverList：书籍列表
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final book = books[i];
                return ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: Text(book.title),
                  subtitle: Text('${book.author} · ${book.category}'),
                  trailing: Text('${book.borrowCount}次'),
                );
              },
              childCount: books.length,
            ),
          ),
        ],
      ),
    );
  }
}
