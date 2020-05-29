import 'package:newspaperapp/models/aticle_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=b6215eea9749489b8cba7bacea6cbd70";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              publishedAt: element["publishedAt"],
              description: element['description'],
              url: element['url'],
              urlToImage: element["urlToImage"],
              content: element["content"]);

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=b6215eea9749489b8cba7bacea6cbd70";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              publishedAt: element["publishedAt"],
              description: element['description'],
              url: element['url'],
              urlToImage: element["urlToImage"],
              content: element["content"]);

          news.add(articleModel);
        }
      });
    }
  }
}

class SourceNewsClass {
  List<ArticleModel> news = [];
  List<SourceModel> source = [];
  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=b6215eea9749489b8cba7bacea6cbd70";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          jsonData["source"].forEach((element) {
            if (element["name"] == "The Times of India") {
              SourceModel sourceModel =
                  SourceModel(id: element["id"], name: element["name"]);
              source.add(sourceModel);
            }
          });
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              publishedAt: element["publishedAt"],
              description: element['description'],
              url: element['url'],
              urlToImage: element["urlToImage"],
              content: element["content"]);

          news.add(articleModel);
        }
      });
    }
  }
}
