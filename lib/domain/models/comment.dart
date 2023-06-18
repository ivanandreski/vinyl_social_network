import 'package:vinyl_social_network/domain/models/user.dart';

class Comment {
  final int id;
  final String body;
  final DateTime createdAt;
  final List<Comment> replies;
  final User user;

  Comment({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.replies,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      body: json['body'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromResponse(json['user']),
      replies: Comment.fromJsonList(json['replies']),
    );
  }

  static List<Comment> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Comment.fromJson(json)).toList();
  }

  int getTotalComments() {
    int count = 1; // Start with 1 for the current comment

    for (Comment reply in replies) {
      count += reply.getTotalComments(); // Recursively calculate total comments for each reply
    }

    return count;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'body': body,
    'createdAt': createdAt.toString(),
    'replies': [],
    'user': user.toJson(),
  };
}