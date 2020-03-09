import 'package:flutter/material.dart';

void main() => runApp(Dashboard());

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color.fromRGBO(255, 82, 48, 1);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, right: 15.0, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black54,
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_none),
                      color: Colors.black54,
                      iconSize: 30.0,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    // ignore: always_specify_types
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0.0, 0.3),
                          blurRadius: 15.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                '28000.00',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                'Available Diamond',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.show_chart),
                            color: Colors.white,
                            iconSize: 30.0,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0),
              child: Text(
                'Recent Activity',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.purple.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'MR',
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Sell Activity',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Text(
                                'Withdraw or sell',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '- 240.0',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(),
                  ),
                  Row(
                    children: <Widget>[
                      Material(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.purple.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'TT',
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Received Activity',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Text(
                                'Rewarded diamond',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14.0),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '360.0',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      )
                    ],
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
