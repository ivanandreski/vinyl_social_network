import 'package:flutter/material.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50,),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Search people'),
            onTap: () {
              Navigator.pushNamed(context, PeopleView.route);
            },
          ),
          ListTile(
            title: const Text('Maybe settings for now nothing'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
