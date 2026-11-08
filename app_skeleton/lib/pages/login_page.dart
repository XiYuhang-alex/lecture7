import 'package:flutter/material.dart';
import '../data/auth_service.dart';

/// 独立研究任务2：路由守卫思路
/// 未登录时拦截跳转，登录后放行
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = AuthService.isLoggedIn;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() {
    if (_controller.text.isNotEmpty) {
      AuthService.login(_controller.text);
      setState(() => _isLoggedIn = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('欢迎，${_controller.text}！已放行后续跳转')),
      );
    }
  }

  void _logout() {
    AuthService.logout();
    setState(() => _isLoggedIn = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('路由守卫演示')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              _isLoggedIn ? Icons.check_circle : Icons.lock,
              size: 80,
              color: _isLoggedIn ? Colors.green : Colors.grey,
            ),
            const SizedBox(height: 24),
            Text(
              _isLoggedIn ? '当前已登录：${AuthService.username}' : '尚未登录',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (!_isLoggedIn) ...[
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('登录'),
              ),
            ] else ...[
              const Text(
                '登录后即可访问受保护页面。\n'
                '实现思路：在 onGenerateRoute 中检查 AuthService.isLoggedIn，\n'
                '未登录时重定向到 /login。',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _logout,
                child: const Text('退出登录'),
              ),
              const SizedBox(height: 16),
              // 测试受保护页面跳转
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/protected'),
                child: const Text('访问受保护页面'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 受保护页面：需要登录才能访问
class ProtectedPage extends StatelessWidget {
  const ProtectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('受保护页面')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_user, size: 80, color: Colors.green),
            const SizedBox(height: 16),
            Text('欢迎 ${AuthService.username}，你已成功访问受保护页面！'),
          ],
        ),
      ),
    );
  }
}
