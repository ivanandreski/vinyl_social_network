// import 'package:flutter/cupertino.dart';
//
// class CommentTree extends StatelessWidget {
//   final List<Comment>
//
//   const CommentTree({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: comments.length,
//       itemBuilder: (context, index) {
//         final comment = comments[index];
//         return ListTile(
//           // todo: make this look better
//           title: Text(comment.body),
//           subtitle: _buildCommentTree(comment.replies),
//         );
//       },
//     );
//   }
//
// }

// todo: TEST IF THIS WOULD UPDATE AFTER MAKING CREATE COMMENT LOGIC