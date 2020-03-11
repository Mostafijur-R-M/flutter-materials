import 'package:device_id/device_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/screen/home.dart';
import 'package:loginui/screen/sign_up_screen.dart';
import 'package:progress_dialog/progress_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String giveId = '123456';
  String getId = '';

  ProgressDialog dialog;

  @override
  Widget build(BuildContext context) {
    final DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('Users');

    showDialog();
    getDeviceImeiId();
    setState(() {
      userRef.child(giveId).once().then((DataSnapshot snapshot) {
        getId = '${snapshot.value['uid']}';
        print('getId: ' + getId);
        print('giveId: ' + giveId);
      });
    });
    // ignore: always_specify_types
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          dialog.dismiss();
          return SignUpScreen();
        }
        if (giveId == getId) {
          dialog.dismiss();
          Fluttertoast.showToast(msg: 'match: ' + getId);
          print('match: ' + getId);
          return HomeScreen();
        } else {
          dialog.dismiss();
          Fluttertoast.showToast(msg: 'not match: ' + getId);
          print('not match: ' + getId);
          return SignUpScreen();
        }
      },
    );
  }

  // ignore: avoid_void_async
  void getDeviceImeiId() async {
    print('called method');
    giveId = await DeviceId.getID;
  }

  // ignore: avoid_void_async
  void showDialog() async {
    dialog = ProgressDialog(context);
    await dialog.show();
  }
}
