// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Media {
  final int id;
  final String title;
  final String author;
  final int type; //0:film, 1:série, 2:livre
  final String img;

  Media(this.id, this.title, this.type, this.author, this.img);
}
