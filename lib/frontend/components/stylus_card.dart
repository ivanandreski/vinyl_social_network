import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinyl_social_network/domain/models/stylus.dart';
import 'package:vinyl_social_network/domain/view_model/stylus_view_model.dart';
import 'package:vinyl_social_network/frontend/dialogs/confirm_dialog.dart';

class StylusCard extends StatefulWidget {
  late final Stylus stylus;

  StylusCard({required this.stylus, super.key});

  @override
  State<StylusCard> createState() => _StylusCardState();
}

class _StylusCardState extends State<StylusCard> {
  bool _open = false;

  _toggleOpen() {
    setState(() {
      _open = !_open;
    });
  }

  @override
  Widget build(BuildContext context) {
    final stylusViewModel = context.watch<StylusViewModel>();
    
    return Center(
        child: GestureDetector(
            onTap: () {
              _toggleOpen();
            },
            child: Card(
                color: !widget.stylus.isRetired == true
                    ? Colors.white
                    : Colors.redAccent,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Icon(Icons.music_note),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                                child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    widget.stylus.name)),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                                child: Text(
                                    textAlign: TextAlign.center,
                                    "Playtime: ${widget.stylus.playtime}")), // todo: convert this so h:m:s format
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            ConfirmDialog()).then((value) async => {
                                          if (value)
                                            {
                                              await stylusViewModel.deleteStylus(widget.stylus.stylusId)
                                            }
                                        });
                                  },
                                  icon: const Icon(Icons.delete))),
                        ],
                      ),
                      Visibility(
                        visible: _open,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const SizedBox(width: 12),
                            TextButton(
                              child: Text(widget.stylus.isRetired ? 'Reemploy' : 'Retire'),
                              onPressed: () async {
                                await stylusViewModel.retireStylus(widget.stylus.stylusId);
                                _toggleOpen();
                              },
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
