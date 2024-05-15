import 'package:assignment/views/community.dart';
import 'package:assignment/views/feed.dart';
import 'package:assignment/views/liked.dart';
import 'package:assignment/views/saved.dart';
import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    Feed(),
    Liked(),
    Community(),
    Saved(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFc6c4c4),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu),
            Spacer(),
            Text(
                'DEMO APP',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Spacer(),
            Stack(
              children: [
                Icon(Icons.notifications_none),
                Positioned(
                  top: 1,
                  right: 3,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        margin: EdgeInsets.only(bottom: 16.0),
        child: CustomNavigationBar(
          iconSize: 35.0,
          selectedColor: Colors.blue,
          unSelectedColor: Colors.white,
          backgroundColor: Colors.black87,
          borderRadius: Radius.circular(12.0),
          items: [
            CustomNavigationBarItem(
              title: Text(
                  "Feed",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.home,
              ),
            ),
            CustomNavigationBarItem(
              title: Text(
                "Liked",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.favorite,
              ),
            ),
            CustomNavigationBarItem(
              title: Text(
                "Community",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.people_alt,
              ),
            ),
            CustomNavigationBarItem(
              title: Text(
                "Saved",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                Icons.bookmark,
              ),
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          isFloating: true,
        ),
      ),
    );
  }
}
