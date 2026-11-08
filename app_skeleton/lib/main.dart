import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/list_page.dart';
import 'pages/detail_page.dart';
import 'pages/sliver_page.dart';
import 'pages/login_page.dart';
import 'pages/transition_page.dart';
import 'data/auth_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '图书管理系统',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // 命名路由表（课程统一采用）
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/list': (_) => const ListPage(),
        '/detail': (_) => const DetailPage(),
        '/sliver': (_) => const SliverPage(),
        '/login': (_) => const LoginPage(),
        '/transition': (_) => const TransitionPage(),
        // /protected 不注册在 routes 中，由 onGenerateRoute 处理（路由守卫）
      },
      // 路由守卫：统一处理未注册路由 + 登录拦截
      onGenerateRoute: (settings) {
        // 受保护页面：未登录时重定向到登录页
        if (settings.name == '/protected') {
          if (!AuthService.isLoggedIn) {
            return MaterialPageRoute(
              builder: (_) => const LoginPage(),
              settings: settings,
            );
          }
          return MaterialPageRoute(
            builder: (_) => const ProtectedPage(),
            settings: settings,
          );
        }
        // 其他未注册路由返回首页
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      },
    );
  }
}
