// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'media.dart';

final libraryInstance = Library()
  //-------------- FILMS --------------
  ..addMedia(
    title: 'Avengers',
    authorName: 'Ursula K. Le Guin',
    type: 0,
    img: 'assets/imgs/films/avengers.jpg',
  )
  ..addMedia(
    title: 'Fast & Furious',
    authorName: 'Rob Cohen',
    type: 0,
    img: 'assets/imgs/films/fast-and-furious.jpg',
  )
  ..addMedia(
    title: 'Harry potter',
    authorName: 'J.K. Rowling',
    type: 0,
    img: 'assets/imgs/films/harry-potter.jpg',
  )
  ..addMedia(
    title: 'Interstellar',
    authorName: 'Ursula K. Le Guin',
    type: 0,
    img: 'assets/imgs/films/interstellar.jpg',
  )
  //-------------- SERIES --------------
  ..addMedia(
    title: 'Downton Abbey',
    authorName: 'test name',
    type: 1,
    img: 'assets/imgs/series/downton-abbey.jpg',
  )
  ..addMedia(
    title: 'Friends',
    authorName: 'test name',
    type: 1,
    img: 'assets/imgs/series/friends.jpg',
  )
  ..addMedia(
    title: 'Game Of Thrones',
    authorName: 'test name',
    type: 1,
    img: 'assets/imgs/series/game-of-thrones.jpg',
  )
  ..addMedia(
    title: 'Peaky Blinders',
    authorName: 'test name',
    type: 1,
    img: 'assets/imgs/series/peaky-blinders.jpg',
  )
  ..addMedia(
    title: 'Stranger Things',
    authorName: 'test name',
    type: 1,
    img: 'assets/imgs/series/stranger-things.jpg',
  )
  //-------------- LIVRES --------------
  ..addMedia(
    title: 'Attaque des Titans',
    authorName: 'Hajime Isayama',
    type: 2,
    img: 'assets/imgs/livres/attaque-des-titans.jpg',
  )
  ..addMedia(
    title: 'Cherub',
    authorName: 'test name',
    type: 2,
    img: 'assets/imgs/livres/cherub.jpg',
  )
  ..addMedia(
    title: 'Harry Potter',
    authorName: 'test name',
    type: 2,
    img: 'assets/imgs/livres/harry-potter.jpg',
  )
  ..addMedia(
    title: 'Seigneur des anneaux',
    authorName: 'test name',
    type: 2,
    img: 'assets/imgs/livres/seigneur-des-anneaux.jpg',
  );

class Library {
  final List<Media> allMedias = [];

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

    print("GLOBAL " + (allMedias[id].liked).toString());
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
