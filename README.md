# lecture7 - 可滚动组件与多页面结构

第7课（第9周）课堂作业：Flutter 可滚动组件与多页面结构实践。

## 项目结构

```
lecture7/
├── app_skeleton/              # Flutter 案例复现 + 自主实践 + 独立研究
│   ├── lib/
│   │   ├── main.dart          # 入口，命名路由表 + 路由守卫
│   │   ├── models/
│   │   │   └── book.dart      # Book 数据模型
│   │   ├── data/
│   │   │   ├── books_data.dart    # 模拟数据（20条 + 分页生成）
│   │   │   └── auth_service.dart  # 登录状态服务（路由守卫）
│   │   ├── pages/
│   │   │   ├── home_page.dart     # 首页 GridView 分类入口
│   │   │   ├── list_page.dart     # 列表页 ListView.builder + 分页
│   │   │   ├── detail_page.dart   # 详情页（接收 Book 参数）
│   │   │   ├── sliver_page.dart   # 独立研究1：CustomScrollView + Sliver
│   │   │   ├── login_page.dart    # 独立研究2：路由守卫（登录）
│   │   │   └── transition_page.dart # 独立研究3：自定义转场
│   │   └── widgets/
│   │       ├── book_tile.dart     # 复用组件1：书籍列表项
│   │       ├── category_card.dart # 复用组件2：分类卡片
│   │       └── load_more_button.dart # 复用组件3：加载更多按钮
│   └── assets/
│       └── books.json             # 书籍数据 JSON
├── screenshots/               # 运行截图（8张全屏）
├── mapp-progress-report-7.docx # 进度报告
└── README.md
```

## 功能清单

### 案例复现（app_skeleton）
- 首页 → 列表 → 详情三页跳转闭环
- ListView.builder 懒构建渲染 20 条数据
- 命名路由表注册，pushNamed 跳转
- 详情页接收强类型 Book 参数
- 列表页长按筛选 → pop 带值回传首页 AppBar

### 自主实践
1. 列表分页模拟：LoadMoreButton 每次追加 20 条
2. 命名路由表：6 条路由，全部命名式
3. 参数与返回值：去程 Book 强类型，回程筛选值生效
4. 组件抽取：BookTile、CategoryCard、LoadMoreButton 三个参数化组件
5. AI 使用标注：见进度报告第七节

### 独立研究
1. CustomScrollView + SliverAppBar + SliverGrid + SliverList 同屏滚动
2. 路由守卫：onGenerateRoute 拦截 /protected，未登录跳转 /login
3. 自定义转场：PageRouteBuilder 实现渐隐、滑动、缩放旋转

## 运行方式

```bash
cd app_skeleton
flutter pub get
flutter run -d web-server --web-port 8080
```

浏览器访问 http://localhost:8080

## Git 提交记录

```
f2e13ab feat: independent research (sliver, route guard, transitions)
70da12d feat: grid home & pop-with-value filter
416a9dd feat: named routes & typed arguments
acb32b2 feat: list page with builder
```
