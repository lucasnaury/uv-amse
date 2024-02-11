// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:media_app/src/widgets/media_list.dart';

import '../data.dart';

class MediasScreen extends StatefulWidget {
  final Library library;
  final ValueChanged<Media> onTap;
  final Function toggleFavCallback;

  const MediasScreen({
    required this.library,
    required this.onTap,
    required this.toggleFavCallback,
    super.key,
  });

  @override
  State<MediasScreen> createState() => _MediasScreenState();
}

class _MediasScreenState extends State<MediasScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medias'),
          bottom: TabBar(
            tabs: const [
              Tab(
                text: 'Films',
                icon: Icon(Icons.camera_roll),
              ),
              Tab(
                text: 'Séries',
                icon: Icon(Icons.live_tv),
              ),
              Tab(
                text: 'Livres',
                icon: Icon(Icons.menu_book),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MediaList(
              medias: widget.library.films,
              toggleFavCallback: widget.toggleFavCallback,
              onTap: widget.onTap,
            ),
            MediaList(
              medias: widget.library.series,
              toggleFavCallback: widget.toggleFavCallback,
              onTap: widget.onTap,
            ),
            MediaList(
              medias: widget.library.livres,
              toggleFavCallback: widget.toggleFavCallback,
              onTap: widget.onTap,
            )
          ],
        ),
      ),
    );
  }
}
