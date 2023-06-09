import 'package:flutter/material.dart';
import 'package:vinyl_social_network/frontend/components/bottom_nav_bar.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/views/collection_view.dart';
import 'package:vinyl_social_network/frontend/views/posts_view.dart';
import 'package:vinyl_social_network/frontend/views/profile_view.dart';
import 'package:vinyl_social_network/frontend/views/stylus_view.dart';

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
          alignment: Alignment.center,
          child: StylusView(),
        ),
        Container(
          alignment: Alignment.center,
          child: StylusView(),
        ),
        Container(
          child: const ProfileView(),
        ),
      ][currentPageIndex],
    );
  }
}
