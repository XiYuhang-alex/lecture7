/// 简易登录状态服务（本地标志位）
/// 用于演示路由守卫：未登录时拦截跳转
class AuthService {
  static bool _isLoggedIn = false;
  static String _username = '';

  static bool get isLoggedIn => _isLoggedIn;
  static String get username => _username;

  static void login(String name) {
    _isLoggedIn = true;
    _username = name;
  }

  static void logout() {
    _isLoggedIn = false;
    _username = '';
  }
}
