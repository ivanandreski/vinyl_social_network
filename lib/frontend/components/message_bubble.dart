import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/models/message.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/service/account_service.dart';

import '../../utils/util_functions.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final alignment = message.senderId == profileViewModel.user!.id
        ? Alignment.centerRight
        : Alignment.centerLeft;
    final color = message.senderId == profileViewModel.user!.id
        ? Theme.of(context).primaryColor
        : Colors.grey.shade300;
    final textColor = message.senderId == profileViewModel.user!.id
        ? Colors.white
        : Colors.black;

    return Column(
      crossAxisAlignment: message.senderId == profileViewModel.user!.id
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          alignment: alignment,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              message.body,
              style: TextStyle(fontSize: 16.0, color: textColor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dateTimeToDateTimeString(message.createdAt),
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
