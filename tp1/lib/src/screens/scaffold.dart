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
          if (idx == 0) goRouter.go('/medias/films');
          if (idx == 1) goRouter.go('/liked');
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Media',
            icon: Icons.list,
          ),
          AdaptiveScaffoldDestination(
            title: 'Liked',
            icon: Icons.favorite,
          ),
        ],
      ),
    );
  }
}
