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

// import 'package:flutter/material.dart';
// import 'package:vinyl_social_network/frontend/views/collection_view.dart';
// import 'package:vinyl_social_network/frontend/views/profile_view.dart';
//
// class BottomNavBar extends StatelessWidget {
//   final int _index;
//
//   const BottomNavBar([this._index = 0]);
//
//   _onItemTapped(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         Navigator.pushReplacementNamed(context, CollectionView.route, arguments: {'currentIndex': index});
//         break;
//       case 1:
//         break;
//       case 2:
//         break;
//       case 3:
//         Navigator.pushReplacementNamed(context, ProfileView.route, arguments: {'currentIndex': index});
//         break;
//       default:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.music_note),
//           label: 'Collection',
//           backgroundColor: Colors.grey,
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.business),
//           label: 'Business',
//           backgroundColor: Colors.grey,
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.school),
//           label: 'School',
//           backgroundColor: Colors.grey,
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'Profile',
//           backgroundColor: Colors.grey,
//         ),
//       ],
//       selectedItemColor: Colors.purpleAccent,
//       currentIndex: _index,
//       onTap: (index) {
//         _onItemTapped(context, index);
//       },
//     );
//   }
// }
