import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:vinyl_social_network/api/chat_service.dart';
import 'package:vinyl_social_network/domain/view_model/chats_view_model.dart';
import 'package:vinyl_social_network/frontend/components/custom_circular_progress_indicator.dart';
import 'package:vinyl_social_network/frontend/components/message_bubble.dart';

class ChatView extends StatefulWidget {
  static const String route = "chat";

  const ChatView({super.key});

  @override
  State<StatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final _chatService = ChatService.instance;

  Timer? timer;

  ChatsViewModel? chatsViewModel;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      chatsViewModel?.fetchChats();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatKey = ModalRoute.of(context)!.settings.arguments as String;
    chatsViewModel ??= context.watch<ChatsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(chatKey.split('!##!')[1]),
      ),
      body: chatsViewModel == null
          ? CustomCircularProgressIndication()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount:
                        chatsViewModel!.getMessagesForKey(chatKey).length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageBubble(
                        message:
                            chatsViewModel!.getMessagesForKey(chatKey)[index],
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () async {
                          String messageText =
                              _textEditingController.text.trim();
                          if (messageText.isNotEmpty) {
                            final response = await _chatService.sendMessage(
                                message: messageText,
                                receiverId:
                                    int.parse(chatKey.split('!##!')[0]));
                            if (response != null) {
                              chatsViewModel!
                                  .addMessageToChat(chatKey, response);
                              _textEditingController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                              _scrollToTop();
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Something went wrong!'),
                                ));
                              }
                            }
                          }
                        },
                        child: Text('Send'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
