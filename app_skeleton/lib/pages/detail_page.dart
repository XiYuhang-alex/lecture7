import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/books_data.dart';

/// 详情页：接收路由参数 Book 实例，完整显示字段
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 接收强类型参数；无参数时取第一本（便于 URL 直接访问演示）
    final args = ModalRoute.of(context)!.settings.arguments;
    final book = (args is Book) ? args : BooksData.baseBooks.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.cover,
                  width: 150,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 150,
                    height: 220,
                    color: Colors.grey[300],
                    child: const Icon(Icons.menu_book, size: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '作者：${book.author}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '分类：${book.category}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${book.rating.toStringAsFixed(1)} 分',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.visibility, size: 20),
                const SizedBox(width: 4),
                Text(
                  '借阅 ${book.borrowCount} 次',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '内容简介',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              book.description,
              style: const TextStyle(fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 24),
            // 返回按钮：pop 无值
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('返回列表'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
