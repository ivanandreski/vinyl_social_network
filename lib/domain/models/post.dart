import 'package:isar/isar.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
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

  Post(
      {required this.postId,
      required this.title,
      required this.likes,
      required this.youLiked,
      required this.postedOn,
      required this.user,
      required this.album});
}
