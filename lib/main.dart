import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Headlines());
}

class Headlines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Headlines',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        fontFamily: 'Lato',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.redAccent,
        fontFamily: 'Lato',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  String uri = 'https://newsapi.org/v2/top-headlines?country=in';
  String defaultImageUrl =
      'http://saveabandonedbabies.org/wp-content/uploads/2015/08/default.png';
  var newsList = List<dynamic>();

  @override
  void initState() {
    super.initState();
    fetchHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Stack(
        children: <Widget>[
          list(),
          isLoading ? Center(child: CircularProgressIndicator()) : Container()
        ],
      ),
    );
  }

  launchUrl(url) {
    launch(url);
  }

  Widget list() {
    return (ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final item = newsList[index];
          final title = item['title'];
          final urlToImage = item['urlToImage'];
          final author = item['author'];
          final publishedAt = item['publishedAt'];
          return InkWell(
            onTap: () {
              launchUrl(item['url']);
            },
            child: Card(
                child: Column(
              children: <Widget>[
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: urlToImage != null ? urlToImage : defaultImageUrl,
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        textWidget(
                            title != null ? title : 'Title Not Avaiable'),
                        Row(
                          children: <Widget>[
                            publishedAt != null
                                ? Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: textWidget(formatDate(publishedAt)),
                                  )
                                : Container(),
                            textWidget(author != null ? "- $author" : ""),
                          ],
                        )
                      ],
                    ))
              ],
            )),
          );
        }));
  }

  String formatDate(String time) =>
      new DateFormat("yMMMd").add_jm().format(DateTime.parse(time).toLocal());

  Widget textWidget(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget appBar(context) {
    return AppBar(
      title: Text('headlines'),
      elevation: 0.0,
    );
  }

  Future<void> fetchHeadlines() async {
    isLoading = true;
    Map<String, String> headers = {
      "X-Api-Key": "",
      "Content-type": "application/json"
    };
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      setState(() {
        newsList = body['articles'];
        isLoading = false;
      });
    } else {
      throw Exception("Failed response.");
    }
  }
}
