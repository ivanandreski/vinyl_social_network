import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/view_model/chats_view_model.dart';
import 'package:vinyl_social_network/frontend/components/custom_circular_progress_indicator.dart';
import 'package:vinyl_social_network/frontend/components/nav_drawer.dart';
import 'package:vinyl_social_network/frontend/views/chat_view.dart';
import 'package:vinyl_social_network/frontend/views/people_view.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  @override
  State<StatefulWidget> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  @override
  Widget build(BuildContext context) {
    final chatsViewModel = context.watch<ChatsViewModel>();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, PeopleView.route);
          },
          child: const Icon(Icons.person),
        ),
        appBar: AppBar(title: const Text("Chat")),
        body: chatsViewModel.loading
            ? const CustomCircularProgressIndication()
            : RefreshIndicator(
            onRefresh: () async {
              chatsViewModel.setLoading(true);
              chatsViewModel.fetchChats();
            },
            child: ListView.builder(
              itemCount: chatsViewModel.chats.keys.length,
              itemBuilder: (BuildContext context, int index) {
                String chatKey = chatsViewModel.chats.keys.toList()[index];

                return GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(context, ChatView.route,
                        arguments: chatKey)
                  },
                  child: Card(
                    elevation: 4.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        chatKey.split('!##!')[1],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                );
              },
            )));
  }
}
