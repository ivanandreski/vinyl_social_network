import 'dart:convert';

import 'package:vinyl_social_network/domain/models/message.dart';
import 'package:vinyl_social_network/service/account_service.dart';
import 'package:vinyl_social_network/utils/constants/general.dart';
import 'package:http/http.dart' as http;

class ChatService {
  static final ChatService _instance = ChatService._privateConstructor();

  ChatService._privateConstructor();

  static ChatService get instance => _instance;

  Future<Message?> sendMessage({required String message, required int receiverId}) async {
    final url =
        Uri.parse('${Constants.apiUrl}/api/chat/send/$receiverId');
    final token = await AccountService.instance.getToken();
    if (token == null) {
      return null;
    }
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"body": message}));
    if(response.statusCode == 201) {
      return Message.fromResponse(json.decode(response.body));
    }

    return null;
  }

  Future<Map<String, List<Message>>> getChats() async {
    final url = Uri.parse(
        '${Constants.apiUrl}/api/chat');
    final token = await AccountService.instance.getToken();
    if (token == null) {
      return {};
    }
    final response = await http.get(url, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode == 200) {
      final data = json.decode(response.body);

      Map<String, List<Message>> chats = {};
      data.forEach((key, value) => {
        chats[key] = value.map<Message>((r) => Message.fromResponse(r)).toList()
      });

      return chats;
    }

    return {};
  }
}
