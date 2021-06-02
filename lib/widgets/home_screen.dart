import 'package:flutter/material.dart';

import '../screens/picture_list_screen.dart';
import '../screens/add_picture_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    PicturesListScreen(),
    AddPictureScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _children[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey[800],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark_rounded),
              label: 'Images',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo_rounded),
            label: 'Click',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
