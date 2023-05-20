import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/api/play_session_service.dart';
import 'package:vinyl_social_network/domain/models/album.dart';
import 'package:vinyl_social_network/domain/view_model/post_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/profile_view_model.dart';
import 'package:vinyl_social_network/domain/view_model/stylus_view_model.dart';

class CreatePlaySessionDialog extends StatefulWidget {
  late final Album album;

  CreatePlaySessionDialog({required this.album, super.key});

  @override
  State<CreatePlaySessionDialog> createState() =>
      _CreatePlaySessionDialogState();
}

class _CreatePlaySessionDialogState extends State<CreatePlaySessionDialog> {
  final _playSessionService = PlaySessionService.instance;

  int _stylusId = -1;

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final stylusViewModel = context.watch<StylusViewModel>();
    if (_stylusId == -1 && stylusViewModel.activeStyluses.isNotEmpty) {
      setState(() {
        _stylusId = stylusViewModel.activeStyluses[0].stylusId;
      });
    }

    return AlertDialog(
        title: const Text('Choose a stylus'),
        content: stylusViewModel.activeStyluses.isNotEmpty
            ? Column(
                children: stylusViewModel.activeStyluses
                    .map((value) => ListTile(
                          title: Text(value.name),
                          leading: Radio<int>(
                            value: value.stylusId,
                            groupValue: _stylusId,
                            onChanged: (int? value) {
                              setState(() {
                                _stylusId = value!;
                              });
                            },
                          ),
                        ))
                    .toList())
            : Text(
                "You have no active styluses, go to the stylus page and add a new one!"),
        actions: [
          if (stylusViewModel.activeStyluses.isNotEmpty)
            ElevatedButton(
              onPressed: () async {
                await _playSessionService.createPlaySession(
                  stylusId: _stylusId,
                    token: await profileViewModel.token!,
                    discogsId: widget.album.discogsId);
                if (mounted) {
                  Navigator.pop(context, true);
                }
              },
              child: const Text('Submit'),
            ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context, false);
              });
            },
            child: Text('Cancel'),
          ),
        ]);
  }
}
