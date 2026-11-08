import 'package:flutter/material.dart';

/// 可复用"加载更多"按钮组件
/// 变化点参数化：是否加载中、点击回调、文本
class LoadMoreButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String label;

  const LoadMoreButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.label = '加载更多',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.add),
              label: Text(label),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
    );
  }
}
