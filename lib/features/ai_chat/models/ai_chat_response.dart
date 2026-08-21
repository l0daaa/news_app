class AiChatResponse {
  final bool found;
  final String? title;
  final String? summary;
  final String? source;
  final String? date;
  final String? url;
  final String? message; // For when found is false

  AiChatResponse({
    required this.found,
    this.title,
    this.summary,
    this.source,
    this.date,
    this.url,
    this.message,
  });

  factory AiChatResponse.fromJson(Map<String, dynamic> json) {
    return AiChatResponse(
      found: json['found'] ?? false,
      title: json['title'],
      summary: json['summary'],
      source: json['source'],
      date: json['date'],
      url: json['url'],
      message: json['message'],
    );
  }
}
