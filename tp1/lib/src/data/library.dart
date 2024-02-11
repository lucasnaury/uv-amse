// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'media.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Library {
  final List<Media> allMedias = [];

  Future<void> initLibraryFromJson() async {
    String jsonString = await rootBundle.loadString('medias.json');
    List<dynamic> jsonList = json.decode(jsonString);

    for (var jsonData in jsonList) {
      addMedia(
        title: jsonData['title'],
        authorName: jsonData['authorName'],
        type: jsonData['type'],
        img: jsonData['img'],
      );
    }
  }

  void addMedia({
    required String title,
    required String authorName,
    required int type,
    required String img,
  }) {
    var media = Media(allMedias.length, title, type, authorName, img);

    allMedias.add(media);
  }

  Media getMedia(String id) {
    return allMedias[int.parse(id)];
  }

  void toggleFavorite(int id) {
    allMedias[id].liked = !allMedias[id].liked;
  }

  List<Media> get films {
    return allMedias.where((m) => m.type == 0).toList();
  }

  List<Media> get series {
    return allMedias.where((m) => m.type == 1).toList();
  }

  List<Media> get livres {
    return allMedias.where((m) => m.type == 2).toList();
  }

  List<Media> get liked {
    return allMedias.where((m) => m.liked).toList();
  }
}
