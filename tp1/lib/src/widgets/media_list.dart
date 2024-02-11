// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class MediaList extends StatefulWidget {
  List<Media> medias;
  final Function toggleFavCallback;
  final ValueChanged<Media>? onTap;

  MediaList({
    required this.medias,
    required this.toggleFavCallback,
    this.onTap,
    super.key,
  });

  @override
  State<MediaList> createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  @override
  Widget build(BuildContext context) => widget.medias.length > 0
      ? ListView.builder(
          itemCount: widget.medias.length,
          itemBuilder: (context, index) => ListTile(
            leading: Image.asset(
              widget.medias[index].img,
              width: 50,
              height: 200,
            ),
            title: Text(
              widget.medias[index].title,
            ),
            subtitle: Text(
              widget.medias[index].author,
            ),
            trailing: IconButton(
                onPressed: (() {
                  setState(() {
                    widget.toggleFavCallback(widget.medias[index].id);
                  });
                }),
                icon: widget.medias[index].liked
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_outline)),
            onTap: widget.onTap != null
                ? () => widget.onTap!(widget.medias[index])
                : null,
          ),
        )
      : Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cancel_outlined),
            SizedBox(height: 10),
            Text("Aucun média"),
          ],
        ));
}
