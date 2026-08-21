import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ai_chat_response.dart';

class AiChatService {
  final String _url = 'https://khaledyoussef444.app.n8n.cloud/webhook/news-support';

  Future<AiChatResponse> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return AiChatResponse.fromJson(data);
      } else {
        throw Exception('Failed to get response from AI: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to AI service: $e');
    }
  }
}
