// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'media.dart';

final libraryInstance = Library()
  ..addMedia(
      title: 'Left Hand of Darkness',
      authorName: 'Ursula K. Le Guin',
      isPopular: true,
      isNew: true)
  ..addMedia(
      title: 'Too Like the Lightning',
      authorName: 'Ada Palmer',
      isPopular: false,
      isNew: true)
  ..addMedia(
      title: 'Kindred',
      authorName: 'Octavia E. Butler',
      isPopular: true,
      isNew: false)
  ..addMedia(
      title: 'The Lathe of Heaven',
      authorName: 'Ursula K. Le Guin',
      isPopular: false,
      isNew: false);

class Library {
  final List<Media> allMedias = [];

  void addMedia({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) {
    var media = Media(allMedias.length, title, isPopular, isNew, authorName);

    allMedias.add(media);
  }

  Media getMedia(String id) {
    return allMedias[int.parse(id)];
  }

  List<Media> get popularMedias => [
        ...allMedias.where((media) => media.isPopular),
      ];

  List<Media> get newBooks => [
        ...allMedias.where((media) => media.isNew),
      ];
}
