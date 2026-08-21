import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  Future<List<ArticleModel>> fetchNews({String query = 'code'}) async {
    try {
      final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=527e0e500c1f4268a3148bb74d970f28'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articlesJson = data['articles'];

        return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
