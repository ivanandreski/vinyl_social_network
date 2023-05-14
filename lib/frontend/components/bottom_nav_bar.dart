import 'package:flutter/material.dart';
import 'package:vinyl_social_network/frontend/views/collection_view.dart';
import 'package:vinyl_social_network/frontend/views/profile_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, CollectionView.route, arguments: {'currentIndex': index});
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacementNamed(context, ProfileView.route, arguments: {'currentIndex': index});
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Collection',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
          backgroundColor: Colors.grey,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          backgroundColor: Colors.grey,
        ),
      ],
      selectedItemColor: Colors.purpleAccent,
      currentIndex: _index,
      onTap: _onItemTapped,
    );
  }
}
