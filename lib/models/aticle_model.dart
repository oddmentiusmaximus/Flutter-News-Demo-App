class ArticleModel {
  String title;
  String publishedAt;
  String description;
  String url;
  String urlToImage;
  String content;

  ArticleModel({
    this.title,
    this.publishedAt,
    this.url,
    this.description,
    this.content,
    this.urlToImage,
  });
}

class SourceModel {
  String id;
  String name;
  SourceModel({this.id, this.name});
}
