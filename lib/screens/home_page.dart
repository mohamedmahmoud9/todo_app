// import 'dart:html';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoapp/models/entry.dart';
import '../widgets/category_tile.dart';
// import 'dart:async';

import 'package:provider/provider.dart';
import '../providers/entries.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;

  void _showNotification() async {
    await _demoNotification();
  }

  Future<void> _demoNotification() async {
    await Provider.of<Entries>(context, listen: false).fetchAndSetEntries();
    var time = Time(8, 0, 0);
    // var scheduledNotificationDateTime =
    //     DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      // importance: Importance.Max,
      // priority: Priority.High,
      // ticker: 'test ticker'
    );

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);
    var entries = Provider.of<Entries>(context, listen: false);
    var notificationBody =
        entries.totalOngoingItems == 0 && entries.totalCompletedItems > 0
            ? ['Well Done!', 'You are completed all tasks']
            : entries.totalCompletedItems == 0 && entries.totalOngoingItems == 0
                ? ['Add Some Tasks!', "You don't have any tasks yet!"]
                : [
                    'Hello,',
                    'You Have ${entries.totalCompletedItems} Completed Tasks.\n${entries.totalOngoingItems} Are Still Ongoing.'
                  ];

    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      notificationBody[0],
      notificationBody[1],
      time,
      platformChannelSpecifics,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    _demoNotification();
  }

  // Future onSelectNotification(String payload) async {
  //   if (payload != null) {
  //     debugPrint('Notification payload: $payload');
  //   }
  //   await Navigator.of(context).pushNamed('/');
  // }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffececec),
     
      body: Stack(
        children: <Widget>[
          Container(
            // width: width,
            height: height * .35,
            // color: Colors.white,
            decoration: BoxDecoration(
              color: Colors.white,
              // boxShadow: [
              //   BoxShadow(color: Colors.black12, offset: Offset(-1, 5))
              // ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(200, 200),
                // bottomRight: Radius.elliptical(180, -90),
              ),
            ),
          ),
          // FutureBuilder(
          //   future: Provider.of<Entries>(context).fetchAndSetEntries(),
          //   builder: (ctx, snapshot) =>
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
            child: FutureBuilder(
              future: Provider.of<Entries>(context, listen: false)
                  .fetchAndSetEntries(),
              builder: (ctx, snaphot) =>
                  snaphot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(
                          // strokeWidth: 1,
                          // value: 50,
                          // semanticsValue: 'loading',
                          backgroundColor: Color(0xff0bb3d4),
                        ))
                      : Column(
                          children: <Widget>[
                            // height: height * .268,

                            // SizedBox(width: width * .1),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  height: height * .1,
                                  child: FittedBox(
                                    child: Text(
                                      'Hello !',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 52,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.infinity,
                                  // height: height * .05,
                                  child: Consumer<Entries>(
                                    builder: (ctx, entries, _) => FittedBox(
                                      child: Text(
                                        'You Have ${entries.totalCompletedItems} Completed Tasks.\n${entries.totalOngoingItems} Are Still Ongoing.',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            CategoryTile(
                              EntryCategory.work,
                            ),
                            CategoryTile(
                              EntryCategory.personal,
                            ),
                            CategoryTile(
                              EntryCategory.home,
                            ),
                            CategoryTile(
                              EntryCategory.office,
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
      //   ],
      // ),
    );
  }
}
