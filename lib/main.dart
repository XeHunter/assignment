import 'package:assignment/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'proj_provider/event_provider.dart';
import 'views/feed.dart';
import 'proj_provider/like_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => LikedCardsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}