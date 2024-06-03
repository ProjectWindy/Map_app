import 'package:flutter/material.dart';
import 'package:vietmap_map/Screens/Profile/profile.dart';
import 'package:vietmap_map/Screens/auth/SignIn.dart';
import 'package:vietmap_map/Screens/auth/signUp.dart';
import 'package:vietmap_map/features/map_screen/maps_screen.dart';
import 'package:fancy_bottom_navigation_2/fancy_bottom_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<Widget> _scrren = [
    const MapScreen(),
    const ProfilePage(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 1,
        elevation: 0,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _scrren,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   elevation: 0,
      //   selectedItemColor: Colors.blueAccent,
      //   unselectedItemColor: Colors.blue, // Màu cho mục không được chọn
      //   backgroundColor: Colors.black12, // Màu nền cho BottomNavigationBar
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //       _pageController.jumpToPage(index);
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Home'),
      //     // BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings), label: 'Settings'),
      //   ],
      // ),
      bottomNavigationBar: FancyBottomNavigation(
        inactiveIconColor: Colors.blueAccent,
        activeIconColor: Colors.white,
        circleColor: Colors.blueAccent,
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "MAP",
          ),
          TabData(iconData: Icons.settings, title: "Profile"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            _currentIndex = position;
            _pageController.jumpToPage(position);
          });
        },
      ),
    );
  }
}
