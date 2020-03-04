import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:loginui/screen/my_map.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File sampleImage;
  String _myValue;
  String url;
  final formKey = new GlobalKey<FormState>();
  String phoneNumber = '+8801927-033582';
  String email = 'mostafijb@gmail.com';

  //GeoLocator
  LatLng _center;
  Position currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // ignore: avoid_void_async
  void getUserLocation() async {
    currentLocation = await locateUser();
    setState(() async {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print('center $_center');
    Fluttertoast.showToast(msg: 'heeeeeey');
  }
  /*Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
      uploadStatusImage();
    });
  }*/

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate() != null) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference imageRef =
          FirebaseStorage.instance.ref().child('Images');

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask =
          imageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      String ImageUrl =
          (await (await uploadTask.onComplete).ref.getDownloadURL()) as String;
      //String ImageUrl = uploadTask.onComplete.ref.getDownloadURL();

      url = ImageUrl.toString();
      print('Image url: ' + url);
      saveToDatabase(url);
    }
  }

  void saveToDatabase(String url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatDate.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "date": date,
      "time": time,
    };
    ref.child("Images").push().set(data);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(255, 82, 48, 1);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 320,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50.0),
                    bottomRight: Radius.circular(50.0)),
                gradient: LinearGradient(colors: [
                  Colors.orange[900],
                  Colors.orange[800],
                  Colors.orange[500],
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Mostafijur Rahman',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120.0),
                        child: Image.asset(
                          'assets/images/profile.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton.icon(
                    clipBehavior: Clip.antiAlias,
                    onPressed: () {
                      //getImage();
                      Fluttertoast.showToast(msg: 'Select image');
                    },
                    icon: Icon(
                      Icons.file_upload,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Change Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: primaryColor,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mobile_screen_share,
                            size: 25.0,
                            color: primaryColor,
                          ),
                          Text(
                            phoneNumber,
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.mail,
                            size: 25.0,
                            color: primaryColor,
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 25.0,
                            color: primaryColor,
                          ),
                          const Text(
                            'Uttara, Dhaka, Bangladesh',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 22.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.call,
                          size: 40,
                          color: primaryColor,
                        ),
                        onPressed: _launchCall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.email,
                          size: 40,
                          color: primaryColor,
                        ),
                        onPressed: _launchEmail,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.message,
                          size: 40,
                          color: primaryColor,
                        ),
                        onPressed: _launchSMS,
                      ),
                    )
                  ],
                ),
                Container(
                  //decoration: BoxDecoration(color: Colors.pink),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 30.0),
                        decoration: const BoxDecoration(color: primaryColor),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: FloatingActionButton(
                          child: Icon(
                            Icons.location_on,
                            color: primaryColor,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (context) => MyApp()));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget enableUpload() {
    return Container(
      child: new Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: 330.0,
              width: 660.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton.icon(
                onPressed: validateAndSave,
                icon: Icon(Icons.file_upload),
                label: Text('Upload')),
          ],
        ),
      ),
    );
  }

  void _launchCall() async {
    url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open $url';
    }
  }

  void _launchEmail() async {
    url = 'mailto:' + email + '?subject=Help&body=Type%20here...';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open $url';
    }
  }

  void _launchSMS() async {
    url = 'sms:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open $url';
    }
  }

  void _findLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('location: ' + position.toString());
    Fluttertoast.showToast(msg: position.toString());
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  return null;
}
