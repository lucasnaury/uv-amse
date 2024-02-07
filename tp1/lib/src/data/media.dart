// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Media {
  final int id;
  final String title;
  final String author;
  final bool isPopular;
  final bool isNew;

  Media(this.id, this.title, this.isPopular, this.isNew, this.author);
}
