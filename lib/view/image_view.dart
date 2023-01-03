import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../controller/image_controller.dart';

class ImageView extends StatefulWidget {
  final String id;
  final String link;
  const ImageView({super.key, required this.id, required this.link});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60.0,
          title: const Text("Wallpaper"),
        ),
        body: Container(
          margin: const EdgeInsets.all(12),
          child: Column(children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.link,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                key: UniqueKey(),
                fit: BoxFit.cover,
              ),
            )),
            buildTile()
          ]),
        ));
  }

  Widget buildTile() {
    final alreadySaved = ImageController().check(widget.id);
    return Center(
      child: Container(
        margin: const EdgeInsets.all(30),
        child: ListTile(
            title: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              size: 40,
            ),
            onTap: () {
              setState(() {
                Map<String, String> imageData = {'id': widget.id, 'link': widget.link};
                ImageController().change(widget.id, imageData, alreadySaved);
              });
            }),
      ),
    );
  }
}
