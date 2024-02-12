// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    super.key,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Infos'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.perm_media_rounded,
                size: 50,
              ),
              Text(
                "Media app",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 25),
              Text(
                "Cette application permet la gestion des médias (films, séries, livres).",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                "Ceux-ci sont triés par catégories et vous pouvez définir des favoris pour vous y retrouver plus facilement.",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
