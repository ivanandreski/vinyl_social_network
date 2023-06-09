import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/user_service.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/components/person_card.dart';

class PeopleView extends StatefulWidget {
  static const String route = "search-people";

  const PeopleView({super.key});

  @override
  State<StatefulWidget> createState() => _PeopleViewState();
}

class _PeopleViewState extends State<PeopleView> {
  final UserService _userService = UserService.instance;

  String search = "";
  List<dynamic> people = [];

  fetchPeople() async {
    final result = await _userService.searchUsers(search);
    setState(() {
      people = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(title: const Text("Search People")),
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 3, left: 20, right: 20),
              child: TextField(
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                  onChanged: (val) {
                    setState(() {
                      search = val;
                    });
                    fetchPeople();
                  }),
            ),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, bottom: kBottomNavigationBarHeight),
                    itemCount: people.length,
                    itemBuilder: (BuildContext context, int index) {
                      final person = people[index];
                      return PersonCard(id: person['id'], name: person['name']);
                    }))
          ],
        ));
  }
}
