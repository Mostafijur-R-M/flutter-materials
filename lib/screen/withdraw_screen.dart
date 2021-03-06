import 'package:device_id/device_id.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/screen/home.dart';
import 'package:loginui/widgets/CustomAppBar.dart';
import 'package:loginui/widgets/ResponsiveWidget.dart';
import 'package:loginui/widgets/custom_shape_clipper.dart';
import 'package:loginui/widgets/custom_text_field.dart';

class WithDrawScreen extends StatefulWidget {
  @override
  _WithDrawScreenState createState() => _WithDrawScreenState();
}

class _WithDrawScreenState extends State<WithDrawScreen> {
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
  double currentDiamond = 0.0, withdrawDiamond = 0.0;
  DatabaseReference withdrawRef = FirebaseDatabase.instance.reference().child('Withdraw');

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    getImeiId();
    getUserData();
    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
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
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
              child: Image.asset(
            'assets/images/withdraw.png',
          )),
        ),
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            diamondTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.credit_card,
      hint: "Via: Bkash, Rocket, UCash etc.",
      textEditingController: viaController,
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.call,
      hint: "Transaction Mobile Number",
      textEditingController: phoneController,
    );
  }

  Widget diamondTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.attach_money,
      hint: 'Available diamond: ' + diamond,
      textEditingController: diamondController,
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print("Routing to your account");
        print(deviceImeiId);
        confirmWithdraw();
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 2.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.orange[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'Confirm Withdraw',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
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

  void confirmWithdraw() {
    currentDiamond = double.parse(diamond);
    withdrawDiamond =  double.parse(diamondController.text);
    if(currentDiamond >= withdrawDiamond && withdrawDiamond >= 500){
      withdrawProcessing();
    }
    if(withdrawDiamond < 500){
      Fluttertoast.showToast(msg: 'Increase Limit');
    }
    if(withdrawDiamond > currentDiamond){
      Fluttertoast.showToast(msg: 'Limit Exceed');
    }
  }

  void withdrawProcessing() {
    double finalDiamond = currentDiamond - withdrawDiamond;
    Fluttertoast.showToast(msg: 'Successfully withdraw: '+ finalDiamond.toString());
    userRef.child(deviceImeiId).set({
      'name': name,
      'phone': phone,
      'uid': uid,
      'diamond': finalDiamond.toString(),
    });
    withdrawRef.child(deviceImeiId).set({
      'diamond': withdrawDiamond.toString(),
      'via': viaController.text,
      'tnumber': phoneController.text,
      'uid': uid,
      'name': name,
    });
    goToHomaScreen();
  }

  void goToHomaScreen() {
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (context) => HomeScreen(),
    ));
  }
}
