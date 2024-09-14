class Article {
  Article({
    required this.data,
  });

  final List<ArticleData> data;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      data: json["Data"] == null
          ? []
          : List<ArticleData>.from(
              json["Data"]!.map((x) => ArticleData.fromJson(x))),
    );
  }
}

class ArticleData {
  ArticleData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.url,
    required this.body,
    required this.keywords,
  });

  final int? id;
  final String? imageUrl;
  final String? title;
  final String? url;
  final String? body;
  final String? keywords;

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      id: json["ID"],
      imageUrl: json["IMAGE_URL"],
      title: json["TITLE"],
      url: json["URL"],
      body: json["BODY"],
      keywords: json["KEYWORDS"],
    );
  }
}
