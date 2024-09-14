import 'dart:convert';

import 'package:flutter_pagination/apikey.dart';
import 'package:flutter_pagination/article.dart';
import 'package:http/http.dart';

class Repository {
  static const String url = 'https://data-api.cryptocompare.com/news/v1/';

  static Future<List<ArticleData>> getArticles(int limit) async {
    final response = await get(Uri.parse("${url}article/list?limit=$limit"),
        headers: {"Authorization": APIKEY});
    final json = jsonDecode(response.body);
    return Article.fromJson(json).data;
  }
}
