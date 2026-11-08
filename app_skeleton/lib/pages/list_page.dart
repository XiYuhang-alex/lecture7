import 'package:flutter/material.dart';
import '../data/books_data.dart';
import '../models/book.dart';
import '../widgets/book_tile.dart';
import '../widgets/load_more_button.dart';

/// 列表页：ListView.builder 渲染数据
/// 功能：
/// 1. 按传入类别过滤
/// 2. "加载更多"按钮每次追加 20 条（分页模拟）
/// 3. 长按弹层选择"仅看高借阅量"，结果 pop 回首页
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Book> _books = [];
  String _category = '全部';
  bool _loading = false;
  int _loadedCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 接收路由参数：类别
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is String) {
      _category = args;
    }
    if (_books.isEmpty) {
      _loadInitial();
    }
  }

  /// 初始加载：基础 20 条按类别过滤
  void _loadInitial() {
    setState(() {
      _books = _category == '全部'
          ? List.of(BooksData.baseBooks)
          : BooksData.baseBooks.where((b) => b.category == _category).toList();
      _loadedCount = _books.length;
    });
  }

  /// 加载更多：每次追加 20 条
  Future<void> _loadMore() async {
    if (_loading) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 500)); // 模拟网络
    final more = BooksData.generateMore(_loadedCount + 1, 20);
    setState(() {
      // 追加时也按类别过滤
      final filtered = _category == '全部'
          ? more
          : more.where((b) => b.category == _category).toList();
      _books.addAll(filtered);
      _loadedCount += 20;
      _loading = false;
    });
  }

  /// 长按弹层：选择"仅看高借阅量"，结果回传首页
  Future<void> _showFilterSheet(Book book) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('仅看高借阅量（借阅>100）'),
              onTap: () => Navigator.pop(ctx, '高借阅量'),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('仅看高评分（评分>4.0）'),
              onTap: () => Navigator.pop(ctx, '高评分'),
            ),
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text('取消筛选'),
              onTap: () => Navigator.pop(ctx, '全部'),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      // 本地过滤
      setState(() {
        if (result == '高借阅量') {
          _books = _books.where((b) => b.borrowCount > 100).toList();
        } else if (result == '高评分') {
          _books = _books.where((b) => b.rating > 4.0).toList();
        } else {
          _loadInitial();
        }
      });
      // 回传值给首页（验证 pop 带值）
      if (mounted) Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_category 图书列表'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, i) {
                final book = _books[i];
                return BookTile(
                  book: book,
                  onTap: () {
                    // 命名路由跳转详情页，携带 Book 实例
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: book,
                    );
                  },
                  onLongPress: () => _showFilterSheet(book),
                );
              },
            ),
          ),
          LoadMoreButton(
            isLoading: _loading,
            onPressed: _loadMore,
            label: '加载更多（当前 ${_books.length} 条）',
          ),
        ],
      ),
    );
  }
}
