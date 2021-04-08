import 'package:flutter/material.dart';
import 'package:mad_project/screens/home.dart';
import 'package:mad_project/screens/shop_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'chat_page.dart';
import 'consult_page.dart';



class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  List<Widget>pages = [
    Home(),
    ShopPage(),
    ConsultPage(),
    ChatPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        curve: Curves.bounceInOut,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [

          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text("Shop"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.live_help_sharp),
            title: Text("Any help"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.chat),
            title: Text("chats"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
