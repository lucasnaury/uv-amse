// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../data.dart';

class MediaDetailsScreen extends StatelessWidget {
  final Media? media;

  const MediaDetailsScreen({
    super.key,
    this.media,
  });

  @override
  Widget build(BuildContext context) {
    if (media == null) {
      return const Scaffold(
        body: Center(
          child: Text('No media found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(media!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              media!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              media!.author,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
