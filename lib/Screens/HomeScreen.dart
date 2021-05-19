import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kaislicing/Models/News_model.dart';
import 'package:kaislicing/Screens/ProfileEdit.dart';
import 'package:kaislicing/Utils/ApiProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  ApiProvider _apiProvider = ApiProvider();
  List<dataPhone> news = [];
  bool url;
  var apiKey = '788d81ce1b264bd590286386745d90fc';

  Future<NewsModel> getNews() async {
    try {
      var response = await http.get(
          'https://newsapi.org/v2/top-headlines?country=id&apiKey=$apiKey');

      var resbody = jsonDecode(response.body);
      print(resbody);

      if (response.statusCode == 200) {
        var x = NewsModel.fromJson(resbody);

        setState(() {
          x.articles.forEach((element) {
            news.add(dataPhone(
                author: element.author,
                content: element.content,
                title: element.title,
                url: element.url,
                urlToImage: element.urlToImage));
          });
        });
      }
    } catch (e) {
      throw Exception('ERROR');
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Halo, Dio Okta Rovelino'),
                      TextButton(
                          onPressed: () {
                            Get.to(ProfileEdits());
                          },
                          child: Column(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.cog,
                                size: 18,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Settings')
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Scrollbar(
                    isAlwaysShown: true,
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (BuildContext ctx, i) {
                        return Column(
                          children: [
                            Card(
                              elevation: 5.0,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(15.0),
                                title: Text(
                                  news[i].title,
                                  style: TextStyle(fontSize: 18),
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () async {
                                    var url = 'https://facebook.com/';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Text('View News'),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class dataPhone {
  dataPhone(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.source,
      this.publishedAt});
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
}
