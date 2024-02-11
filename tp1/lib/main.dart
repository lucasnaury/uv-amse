// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'src/data/library.dart'; // Importez votre classe Library depuis le fichier où vous l'avez définie

import 'src/app.dart';

void main() async {
  // Use package:url_strategy until this pull request is released:
  // https://github.com/flutter/flutter/pull/77103

  // Use to setHashUrlStrategy() to use "/#/" in the address bar (default). Use
  // setPathUrlStrategy() to use the path. You may need to configure your web
  // server to redirect all paths to index.html.
  //
  // On mobile platforms, both functions are no-ops.
  setHashUrlStrategy();
  // setPathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  var library = Library();
  await library.initLibraryFromJson();

  runApp(const Mediastore());
}
