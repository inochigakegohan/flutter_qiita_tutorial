import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_qiita_tutorial/models/article.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          //検索ボックス
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: TextStyle( //Textstyleを渡す
                 fontSize: 18,
              color: Colors.black,
              ),
              decoration: InputDecoration( // ← InputDecorationを渡す
                hintText: '検索ワードを入力してください',
              ),
            ),
          ),
          //検索結果一覧
        ],
      ),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
    // 1. http通信に必要なデータを準備をする
    // Uri.https([baseUrl], [Urlパス], Map<String,dynamic>[クエリパラメータ])

    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });

    // 2. Qiita APIにリクエストを送る
    // アクセストークンを取得
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    // 3. 戻り値をArticleクラスの配列に変換
    // アクセストークンを含めてリクエストを送信
    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    // 4. 変換したArticleクラスの配列を返す(returnする)
    if (res.statusCode == 200) {
      // モデルクラスへ変換
    } else {
      return [];
    }
// レスポンスをモデルクラスへ変換
    final List<dynamic> body = jsonDecode(res.body);
    return body.map((dynamic json) => Article.fromJson(json)).toList();
  }
}
