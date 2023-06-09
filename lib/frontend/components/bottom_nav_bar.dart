import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  late final Function changeCurrentPageIndex;
  late final Function getIndex;

  BottomNavBar(
      {super.key,
      required this.changeCurrentPageIndex,
      required this.getIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (int index) {
        changeCurrentPageIndex(index);
      },
      selectedIndex: getIndex(),
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.music_note),
          label: 'Collection',
        ),
        NavigationDestination(
          icon: Icon(Icons.post_add),
          label: 'Posts',
        ),
        NavigationDestination(
          icon: Icon(Icons.message),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.music_video),
          label: 'My Styluses',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}