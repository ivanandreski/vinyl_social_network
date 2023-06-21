import 'package:flutter/material.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

class CustomNetworkImage extends StatefulWidget {
  late final String imageUrl;

  CustomNetworkImage({required this.imageUrl});

  @override
  State<StatefulWidget> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    _checkNetwork();
  }

  _checkNetwork() async {
    _show = await isInternetConnectionAvailable();
  }

  @override
  Widget build(BuildContext context) {
    return _show
        ? Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.contain, image: NetworkImage(widget.imageUrl))),
          )
        : Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: const DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/no-image-available.jpg'))),
          );
  }
}
