import 'package:flutter/material.dart';
import 'package:vinyl_social_network/frontend/components/bottom_nav_bar.dart';
import 'package:vinyl_social_network/frontend/views/collection_view.dart';
import 'package:vinyl_social_network/frontend/views/posts_view.dart';
import 'package:vinyl_social_network/frontend/views/profile_view.dart';

class HomeView extends StatefulWidget {
  static const route = '/home';

  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPageIndex = 0;

  _changeCurrentPageIndex(int newPageIndex) {
    setState(() {
      currentPageIndex = newPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
          changeCurrentPageIndex: _changeCurrentPageIndex,
          getIndex: () => currentPageIndex),
      body: <Widget>[
        Container(
            color: Colors.red,
            alignment: Alignment.center,
            child: const CollectionView()),
        Container(
          child: const PostsView(),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          child: const ProfileView(),
        ),
      ][currentPageIndex],
    );
  }
}
