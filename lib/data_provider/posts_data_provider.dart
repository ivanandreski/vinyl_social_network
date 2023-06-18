import 'package:vinyl_social_network/api/post_service.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/service/cache_service.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class PostsDataProvider {
  static final PostsDataProvider _instance = PostsDataProvider._privateConstructor();

  PostsDataProvider._privateConstructor();

  static PostsDataProvider get instance => _instance;

  Future<List<Post>> getPosts() async {
    final cacheService = CacheService.instance;

    if(await isInternetConnectionAvailable()) {
      final posts = await PostService.instance.getPosts();
      cacheService.cachePosts(posts);

      return posts;
    }

    // todo: add toast message for no internet

    return await CacheService.instance.getPosts();
  }
}