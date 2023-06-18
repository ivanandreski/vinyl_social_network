import 'package:flutter/material.dart';
import 'package:vinyl_social_network/api/chat_service.dart';
import 'package:vinyl_social_network/data_provider/chat_data_provider.dart';
import 'package:vinyl_social_network/domain/models/message.dart';

class ChatsViewModel extends ChangeNotifier {
  final _chatService = ChatService.instance;

  bool _loading = true;
  Map<String, List<Message>> _chats = {}; // The string is the userId concated with !##! and then the user full name

  bool get loading => _loading;
  Map<String, List<Message>> get chats => _chats;

  ChatsViewModel() {
    fetchChats();
  }

  fetchChats() async {
    _chats = await ChatDataProvider.instance.getChat();
    setLoading(false);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  List<Message> getMessagesForKey(String key) {
    return _chats[key]!;
  }

  addMessageToChat(String chatKey, Message message) {
    _chats[chatKey]!.add(message);
    _orderMessagesForChat(chatKey);
  }

  _orderMessagesForChat(String chatKey) {
    _chats[chatKey]!.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }
}
