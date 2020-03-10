import 'dart:async';

import 'package:device_id/device_id.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/widgets/CustomAppBar.dart';
import 'package:loginui/widgets/ResponsiveWidget.dart';
import 'package:loginui/widgets/custom_shape_clipper.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class BlogDetailScreen extends StatefulWidget {
  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController viaController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController diamondController = TextEditingController();
  String deviceImeiId = '';
  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child('Users');
  String diamond = '0.0', name = '', phone = '', uid = '';
  double currentDiamond = 0.0, getDiamond = 500.0;
  DatabaseReference withdrawRef =
      FirebaseDatabase.instance.reference().child('Withdraw');

  //timer count
  Timer timer;
  int _start = 20;
  void startTimeer() {}

  //admob integrate
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  //NativeAd _nativeAd;
  InterstitialAd _interstitialAd;
  int _coins = 0;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print('BannerAd event $event');
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print('InterstitialAd event $event');
      },
    );
  }

  /*NativeAd createNativeAd() {
    return NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'adFactoryExample',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("$NativeAd event $event");
      },
    );
  }*/

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()..load();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print('RewardedVideoAd event $event');
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _coins += rewardAmount;
        });
      }
    };
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    //_nativeAd?.dispose();
    _interstitialAd?.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    //startTimeer();
    //Fluttertoast.showToast(msg: _start.toString());
    //print(_start);
    showTimer();
    //showAd();
    getImeiId();
    getUserData();
    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: const EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                SizedBox(
                  height: _height / 35,
                ),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 2 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // ignore: always_specify_types
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 15 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // ignore: always_specify_types
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 4.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // ignore: always_specify_types
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: const Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.asset(
                  'assets/images/confident.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            margin: const EdgeInsets.only(top: 200.0),
            height: 200.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.purple),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  'Defining dummy text Dummy text refers to the bits of content that are used to fill a website mock-up. This text helps web designers better envision how the website will look as a finished product. It is important to understand that dummy text has no meaning whatsoever'),
            ),
          ),
        )
      ],
    );
  }

  Future<void> getImeiId() async {
    deviceImeiId = await DeviceId.getID;
  }

  void getUserData() {
    userRef.child(deviceImeiId).once().then((DataSnapshot snapshot) {
      name = '${snapshot.value['name']}';
      phone = '${snapshot.value['phone']}';
      uid = '${snapshot.value['uid']}';
      diamond = '${snapshot.value['diamond']}';
      print('diamond ' + diamond);
    });
  }

  void showAd() {
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show();

    _interstitialAd ??= createInterstitialAd();
    _interstitialAd
      ..load()
      ..show();
    addDiamondDb();
  }

  void showTimer() {
    const oneSec = Duration(seconds: 1);
    timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
                if (_start == 1) {
                  timer.cancel();
                  Fluttertoast.showToast(msg: _start.toString());
                  Fluttertoast.showToast(msg: 'Congrats! you won 500 diamond.');
                  showAd();
                }
              }
            }));
  }

  void addDiamondDb() {
    currentDiamond = double.parse(diamond);
    final double finalDiamond = currentDiamond + getDiamond;
    userRef.child(deviceImeiId).set({
      'name': name,
      'phone': phone,
      'uid': uid,
      'diamond': finalDiamond.toString(),
    });
  }
}
