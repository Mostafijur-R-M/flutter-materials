import 'package:device_id/device_id.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/card/upcoming_card.dart';
import 'package:loginui/screen/user_profile.dart';
import 'package:loginui/screen/withdraw_screen.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Management',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String diamond = '00';
  String imeiId = '';
  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child('Users');

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(255, 82, 48, 1);
    viewSaveData();
    getImeiId();
    getUserData();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: primaryColor, border: Border.all(color: primaryColor)),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, right: 15.0, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    UserProfileScreen()));
                        Fluttertoast.showToast(msg: 'Go to Profile');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_none),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeCliper(),
                  child: Container(
                    height: 350.0,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            diamond,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Available Diamond',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ],
                      ),
                      Material(
                        elevation: 1.0,
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.blue[300],
                        child: FlatButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 16.0),
                          child: Text(
                            'Withdraw',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        WithDrawScreen()));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 120.0, right: 25.0, left: 25.0),
                  child: Container(
                    width: double.infinity,
                    height: 530.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0.0, 3.0),
                            blurRadius: 15.0,
                          )
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.purple.withOpacity(0.1),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(15.0),
                                      icon: Icon(Icons.bug_report),
                                      color: Colors.purple,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Breaking News',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.blue.withOpacity(0.1),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(15.0),
                                      icon: Icon(Icons.book),
                                      color: Colors.blue,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Blog',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.orange.withOpacity(0.1),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(15.0),
                                      icon: Icon(Icons.games),
                                      color: Colors.orange,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Sports',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.pink.withOpacity(0.1),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(15.0),
                                      icon: Icon(Icons.video_library),
                                      color: Colors.pink,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Watch Tutorial',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.purpleAccent.withOpacity(0.1),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(15.0),
                                      icon: Icon(Icons.card_giftcard),
                                      color: Colors.purpleAccent,
                                      iconSize: 30.0,
                                      onPressed: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Sell Diamond',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.deepPurple.withOpacity(0.1),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(15.0),
                                      icon: Icon(Icons.surround_sound),
                                      color: Colors.deepPurple,
                                      iconSize: 30.0,
                                      onPressed: () {
                                        viewSaveData();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    'Dictionary',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'Money is an economic unit that functions as a generally recognized medium of exchange for transactional purposes in an economy',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                width: 40.0,
                              ),
                              Material(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.blueAccent.withOpacity(0.1),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    saveDataFirebase();
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Text(
                'Upcoming',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0, bottom: 25.0),
              child: Container(
                height: 150.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    UpcomingCard('Credit Card', 85.00, Colors.purple),
                    UpcomingCard('Visa Card', 585.00, Colors.blue),
                    UpcomingCard('Master Card', 857.00, Colors.orange),
                    UpcomingCard(title, 857.00, Colors.green),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  DatabaseReference db = FirebaseDatabase.instance.reference().child('Images');
  void saveDataFirebase() {
    db.child('1').set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide J2EE',
      'url':
          'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_960_720.png'
    });
    db.child('2').set({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to  Flutter'
    });
  }

  String title = '';
  String url = '';
  void viewSaveData() {
    db.child('1').once().then((DataSnapshot snapshot) {
      //Fluttertoast.showToast(msg: 'Data: ${snapshot.value['url']}');
      title = '${snapshot.value['title']}';
      url = '${snapshot.value['url']}';
      print('Data: ${snapshot.value}');
    });
  }

  void getImeiId() async {
    imeiId = (await DeviceId.getID) as String;
    //Fluttertoast.showToast(msg: imeiId);
    print("imeiId " + imeiId);
  }

  void getUserData() {
    userRef.child(imeiId).once().then((DataSnapshot snapshot) {
      diamond = '${snapshot.value['diamond']}';
      print('diamond ' + diamond);
    });
  }
}

class CustomShapeCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 390.0 - 200.0);
    path.quadraticBezierTo(size.width / 2, 280, size.width, 390.0 - 200.0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
