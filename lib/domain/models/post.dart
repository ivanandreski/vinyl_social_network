import 'package:isar/isar.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/models/comment.dart';
import 'package:vinyl_social_network/domain/models/user.dart';

class Post {
  Id id = Isar.autoIncrement;

  late final int postId;
  late final String title;
  late final int likes;
  late final bool youLiked;
  late final DateTime postedOn;

  // relationships
  late final User user;
  late final Album album;

  List<Comment> comments = [];

  Post(
      {required this.postId,
      required this.title,
      required this.likes,
      required this.youLiked,
      required this.postedOn,
        required this.comments,
      required this.user,
      required this.album});

  int get numOfComments {
    int count = 0;

    for (Comment comment in comments) {
      count += comment.getTotalComments(); // Call getTotalComments for each comment in the tree
    }

    return count;
  }

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'title': title,
    'likes': likes,
    'youLiked': youLiked,
    'postedOn': postedOn.toString(),
    'comments': [],
    'user': user.toJson(),
    'album': album.toJson()
  };
}
