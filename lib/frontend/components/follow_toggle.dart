import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/api/user_service.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';

class FollowToggle extends StatefulWidget {
  late final int userId;
  late final bool isFollow;

  FollowToggle({required this.userId, required this.isFollow, super.key});

  @override
  State<StatefulWidget> createState() => _FollowToggleState();

  late final Function toggleLike;
}

class _FollowToggleState extends State<FollowToggle> {
  final _userService = UserService.instance;
  bool _isFollow = false;

  @override
  void initState() {
    super.initState();
    _isFollow = widget.isFollow;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          await _userService.toggleFollowPerson(widget.userId);
          setState(() {
            _isFollow = !_isFollow;
          });
        },
        child: SizedBox(
          width: 70,
          child: Row(children: [
            Text(
              _isFollow ? "Unfollow" : "Follow",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            )
          ]),
        ));
  }
}
