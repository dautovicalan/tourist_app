import 'package:flutter/material.dart';
import 'package:tourist_app/features/locations/presentation/location_list/screen/location_list_screen.dart';
import 'package:tourist_app/features/profile/presentation/profile_detail/screen/profile_screen.dart';

import '../../../locations/presentation/favorite_list/screen/favorite_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final _screens = [
    LocationListScreen(),
    FavoriteListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: (newIndex) => setState(() => index = newIndex),
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              index == 0
                  ? Icons.explore
                  : Icons.explore_outlined,
              color: index == 0
                  ? Color.fromRGBO(209, 116, 56, 1)
                  : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              index == 1
                  ? Icons.favorite
                  : Icons.favorite_outline_rounded,
              color: index == 1
                  ? Color.fromRGBO(209, 116, 56, 1)
                  : Colors.grey,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              index == 2
                  ? Icons.person
                  : Icons.person_outline_rounded,
              color: index == 2
                  ? Color.fromRGBO(209, 116, 56, 1)
                  : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
