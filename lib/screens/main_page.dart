import 'package:flutter/material.dart';
import 'package:mad_project/screens/home.dart';
import 'package:mad_project/shop_page_wrapper.dart';
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
    ShopPageWrapper(),
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
            selectedColor: Colors.pink,
          ),

          SalomonBottomBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text("Shop"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text("any help"),
            selectedColor: Colors.pink,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.help),
            title: Text("FAQ"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
