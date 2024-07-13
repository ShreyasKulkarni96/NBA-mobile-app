import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nbp/statsDetailsScreen.dart';
import 'package:nbp/teamsScreen.dart';
import 'package:nbp/utility/colors.dart';
import 'package:nbp/utility/textview/custom_textview.dart';

import 'gamesScreen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  static final List<Widget> _widgetOptions = <Widget>[
    TeamsScreen(),
    GamesScreen(),
    StatssDetailsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'TEAMS',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'GAMES',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'STATS',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: blackTextColor,
        selectedLabelStyle: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: blackTextColor,
            fontWeight: FontWeight.w500),
        unselectedLabelStyle: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: grayBgColor,
            fontWeight: FontWeight.w500),
        onTap: _onItemTapped,
      ),
    );
  }
}
