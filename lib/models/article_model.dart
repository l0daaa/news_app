class ArticleModel {
  final String title;
  final String? author;
  final String? urlToImage;
  final String publishedAt;
  final String? url;
  final String? description;
  final String? content;

  ArticleModel({
    required this.title,
    this.author,
    this.urlToImage,
    required this.publishedAt,
    this.url,
    this.description,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'] ?? 'No Title',
      author: json['author'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      url: json['url'],
      description: json['description'],
      content: json['content'],
    );
  }
}
