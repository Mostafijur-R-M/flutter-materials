import 'package:flutter/material.dart';
import 'package:loginui/card/blog_card.dart';
import 'package:loginui/screen/blog/detail_screen.dart';
import 'package:loginui/screen/blog/news_card.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 50.0),
                child: Container(
                  height: 150.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => BlogDetailScreen(),
                              ));
                        },
                        child: BlogCard('assets/images/confident.png',
                            'Self Confident', 420, Colors.grey),
                      ),
                      BlogCard('assets/images/student.jpg', 'Student Hack', 420,
                          Colors.pink),
                      BlogCard('assets/images/business.png', 'Start Business',
                          420, Colors.orange),
                      BlogCard('assets/images/goal.jpg', 'Set Goal', 420,
                          Colors.purple),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 500,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, bottom: 10.0, top: 10.0),
                child: Container(
                  //height: 500.0,
                  child: ListView(
                    padding: EdgeInsets.only(top: 10),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      NewsCard('assets/images/fitness.jpg', 'Fitness ', 420,
                          Colors.grey),
                      NewsCard('assets/images/interview.png', 'Job Interview',
                          420, Colors.pink),
                      NewsCard('assets/images/failure.png', 'Failure', 420,
                          Colors.orange),
                      NewsCard('assets/images/hiv.png', 'HIV and AIDS', 420,
                          Colors.purple),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
