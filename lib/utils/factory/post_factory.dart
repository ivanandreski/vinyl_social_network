import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/models/comment.dart';
import 'package:vinyl_social_network/domain/models/post.dart';
import 'package:vinyl_social_network/domain/models/user.dart';
import 'package:vinyl_social_network/utils/factory/album_cache_factory.dart';
import 'package:vinyl_social_network/utils/factory/album_factory.dart';

class PostFactory {
  static final PostFactory _instance = PostFactory._privateConstructor();

  PostFactory._privateConstructor();

  static PostFactory get instance => _instance;

  List<Post> makePostsFromResponse(List<dynamic> response) {
    return response
        .map((postResponse) => Post(
            postId: postResponse['id'],
            title: postResponse['text'],
            likes: postResponse['likes'],
            youLiked: postResponse['you_liked'] == 1 ? true : false,
            postedOn: DateTime.parse(postResponse['created_at']),
            comments: Comment.fromJsonList(postResponse['comments']),
            user: User.fromResponse(postResponse['user']),
            album: Album.fromResponse(postResponse['album_cache'])))
        .toList();
  }
}
