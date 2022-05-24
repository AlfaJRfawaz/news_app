class Article {
  String author;
  String title;
  String content;
  String urlToImage;
  String publishedAt;
  //parameter
  Article(
      {required this.author,
      required this.title,
      required this.content,
      required this.urlToImage,
      required this.publishedAt});

  //? memetakan json object ke model
  factory Article.fromJson(Map<String, dynamic> json) => Article(
    author: json["author"] ?? "Null",
    title: json["title"] ?? "Null",
    content: json["content"] ?? "Null",
    urlToImage: json["urlToImage"] ?? "Null",
    publishedAt: json["publishedAt"] ?? "https://www.btklsby.go.id/images/placeholder/basic.png",
  );
}
