import 'package:flutter/material.dart';
import 'package:vinyl_social_network/frontend/views/user_details_view.dart';

class PersonCard extends StatelessWidget {
  late final int id;
  late final String name;

  PersonCard({required this.id, required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UserDetailsView.route, arguments: id);
            },
            child: Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.person),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    name)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
