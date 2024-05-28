class Article {
  // コンストラクタ
  Article({
    required this.title,
    required this.user,
    this.likesCount = 0, // デフォルト値を0で設定
    this.tags = const [], // デフォルト値を空配列で設定
    required this.createdAt,
    required this.url,
  });

  // プロパティ
  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  final DateTime createdAt;
  final String url;
}