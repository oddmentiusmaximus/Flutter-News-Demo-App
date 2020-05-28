import 'package:flutter/material.dart';
import 'package:newspaperapp/helper/news.dart';
import 'package:newspaperapp/models/aticle_model.dart';
import 'package:newspaperapp/views/web_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[Text("News Demo Section " + widget.category)],
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          date: articles[index].publishedAt,
                          desc: articles[index].description,
                          url: articles[index].url,
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, date;
  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.date,
      @required this.desc,
      @required this.url});
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
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
