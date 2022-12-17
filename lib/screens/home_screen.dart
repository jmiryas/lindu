import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../screens/about_us_screen.dart';
import '../screens/earthquake_screen.dart';
import '../screens/earthquake_magnitude_five_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    EarthquakeScreen(),
    EarthquakeMagnitudeFivePlusScreen(),
    AboutUsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(Icons.waves),
            label: "Gempa Terbaru",
            backgroundColor: Color(containerBackgroundColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.earthAsia),
            label: "Gempa M. 5+",
            backgroundColor: Color(containerBackgroundColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.info),
            label: "Tentang Kami",
            backgroundColor: Color(containerBackgroundColor),
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: unselectedItemColor,
        backgroundColor: const Color(containerBackgroundColor),
      ),
    );
  }
}
