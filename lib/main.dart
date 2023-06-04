import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:travelui/login/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:travelui/screens/categories_info.dart';
import 'package:travelui/screens/login_page.dart';
import 'package:travelui/widgets/custume_drawer.dart';
import 'home_page.dart';
import 'login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'models/movies.dart';
import 'models/provider.dart';

//ignore_for_file: prefer_const_constructors

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  print('User granted permission: ${settings.authorizationStatus}');
  Hive.registerAdapter<Movies>(MoviesAdapter());
  // Hive.registerAdapter(ItemAdapter());
  //Hive.registerAdapter(ItemAdapter());
  await Hive.initFlutter();
  var box = await Hive.openBox('favorite');
  //var box = await Hive.openBox('favorites');

  //var path = Directory.current.path;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => provider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CustumeDrawer(),
          routes: {
            CategoryInfo.routename: (ctx) => CategoryInfo(),
            HomePage.routename: (ctx) => HomePage()
          },
        ));
  }
}
