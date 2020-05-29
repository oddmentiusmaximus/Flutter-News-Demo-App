import 'package:flutter/material.dart';
import 'package:newspaperapp/helper/data.dart';
import 'package:newspaperapp/helper/news.dart';
import 'package:newspaperapp/models/aticle_model.dart';
import 'package:newspaperapp/models/category_model.dart';
import 'package:newspaperapp/views/web_view.dart';

import 'home.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  List<SourceModel> source = new List<SourceModel>();

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getCategories();
    getNews();
  }

  getNews() async {
    SourceNewsClass newsClass = SourceNewsClass();
    await newsClass.getNews();
    articles = newsClass.news;
    source = newsClass.source;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    ///News Sources
                    Container(
                      color: Colors.blueAccent,
                      height: 70,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),

                    ///Articles
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                            id: source[index].id,
                            name: source[index].name,
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            date: articles[index].publishedAt,
                            desc: articles[index].description,
                            url: articles[index].url,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Text(
                    "Powered by NewsAPI.org",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, date, id, name;
  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.date,
      @required this.desc,
      @required this.url,
      @required this.id,
      @required this.name});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.only(bottom: 17),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
