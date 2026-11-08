import 'package:flutter/material.dart';

/// 独立研究任务3：自定义页面转场
/// 使用 PageRouteBuilder 实现渐隐渐现 + 滑动转场
class TransitionPage extends StatelessWidget {
  const TransitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自定义转场演示')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '点击按钮体验不同转场效果',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const _FadePage(),
                    transitionsBuilder: (_, anim, __, child) {
                      // 渐隐渐现
                      return FadeTransition(
                        opacity: anim,
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 800),
                  ),
                );
              },
              icon: const Icon(Icons.opacity),
              label: const Text('渐隐渐现转场'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const _SlidePage(),
                    transitionsBuilder: (_, anim, __, child) {
                      // 从右向左滑动
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: Curves.easeInOut));
                      return SlideTransition(
                        position: anim.drive(tween),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              icon: const Icon(Icons.swipe),
              label: const Text('滑动转场'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const _ScalePage(),
                    transitionsBuilder: (_, anim, __, child) {
                      // 缩放 + 旋转组合
                      return ScaleTransition(
                        scale: anim,
                        child: RotationTransition(
                          turns: anim,
                          child: child,
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 600),
                  ),
                );
              },
              icon: const Icon(Icons.zoom_in),
              label: const Text('缩放旋转转场'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FadePage extends StatelessWidget {
  const _FadePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(title: const Text('渐隐渐现页面')),
      body: const Center(
        child: Text('这是通过 FadeTransition 进入的页面',
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  const _SlidePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(title: const Text('滑动页面')),
      body: const Center(
        child: Text('这是通过 SlideTransition 从右滑入的页面',
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class _ScalePage extends StatelessWidget {
  const _ScalePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(title: const Text('缩放旋转页面')),
      body: const Center(
        child: Text('这是通过 ScaleTransition + RotationTransition 进入的页面',
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
