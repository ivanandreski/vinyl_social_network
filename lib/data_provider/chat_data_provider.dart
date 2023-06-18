import 'package:vinyl_social_network/api/chat_service.dart';
import 'package:vinyl_social_network/api/post_service.dart';
import 'package:vinyl_social_network/domain/models/message.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/service/cache_service.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class ChatDataProvider {
  static final ChatDataProvider _instance = ChatDataProvider._privateConstructor();

  ChatDataProvider._privateConstructor();

  static ChatDataProvider get instance => _instance;

  Future<Map<String, List<Message>>> getChat() async {
    final cacheService = CacheService.instance;

    if(await isInternetConnectionAvailable()) {
      final chat = await ChatService.instance.getChats();
      cacheService.cacheChat(chat);

      return chat;
    }

    // todo: add toast message for no internet

    return await CacheService.instance.getChat();
  }
}