// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class MediaList extends StatelessWidget {
  final List<Media> medias;
  final ValueChanged<Media>? onTap;

  const MediaList({
    required this.medias,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: medias.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            medias[index].title,
          ),
          subtitle: Text(
            medias[index].author,
          ),
          onTap: onTap != null ? () => onTap!(medias[index]) : null,
        ),
      );
}
