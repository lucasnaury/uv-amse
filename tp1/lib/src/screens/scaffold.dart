// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MediastoreScaffold extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const MediastoreScaffold({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          if (idx == 0) goRouter.go('/medias');
          if (idx == 1) goRouter.go('/liked');
          if (idx == 2) goRouter.go('/about');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Medias',
            icon: Icons.list,
          ),
          AdaptiveScaffoldDestination(
            title: 'Favoris',
            icon: Icons.favorite,
          ),
          AdaptiveScaffoldDestination(
            title: 'Infos',
            icon: Icons.info,
          ),
        ],
      ),
    );
  }
}
