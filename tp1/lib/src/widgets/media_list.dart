// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class MediaList extends StatefulWidget {
  final List<Media> medias;
  final Function toggleLikeCallback;
  final ValueChanged<Media>? onTap;

  const MediaList({
    required this.medias,
    required this.toggleLikeCallback,
    this.onTap,
    super.key,
  });

  @override
  State<MediaList> createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: widget.medias.length,
        itemBuilder: (context, index) => ListTile(
          leading: Image.asset(
            widget.medias[index].img,
            width: 50,
            height: 50,
          ),
          title: Text(
            widget.medias[index].title,
          ),
          subtitle: Text(
            widget.medias[index].author,
          ),
          trailing: IconButton(
            icon: Icon(widget.medias[index].liked
                ? Icons.favorite
                : Icons.favorite_outlined),
            onPressed: (() => {
                  setState(() {
                    widget.toggleLikeCallback(index);
                  }),
                }),
          ),
          onTap: widget.onTap != null
              ? () => widget.onTap!(widget.medias[index])
              : null,
        ),
      );
}
