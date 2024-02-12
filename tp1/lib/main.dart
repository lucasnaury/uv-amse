// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'src/data/library.dart';

import 'src/app.dart';

void main() async {
  setHashUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  var library = Library();
  await library.initLibraryFromJson();

  runApp(Mediastore(
    libraryInstance: library,
  ));
}
