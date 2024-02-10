// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:media_app/src/screens/liked.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data.dart';
import 'screens/media_details.dart';
import 'screens/medias.dart';
import 'screens/scaffold.dart';
import 'widgets/media_list.dart';
import 'widgets/fade_transition_page.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final mediasNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'medias shell');

class Mediastore extends StatefulWidget {
  const Mediastore({super.key});

  @override
  State<Mediastore> createState() => _MediastoreState();
}

class _MediastoreState extends State<Mediastore> {
  void toggleFav(int id) {
    setState(() {
      libraryInstance.toggleFavorite(id);
    });
  }

  List<Media> getMedias(int id) {
    switch (id) {
      case 0:
        return libraryInstance.films;
      case 1:
        return libraryInstance.series;
      case 2:
        return libraryInstance.livres;
    }

    return libraryInstance.allMedias;
  }

  int mediaIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/medias',
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return MediastoreScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/medias') => 0,
                  var p when p.startsWith('/liked') => 1,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/medias',
                builder: (context, state) {
                  return MediasScreen(
                    onTap: (int id) {
                      setState(() {
                        mediaIndex = id;
                      });
                    },
                    selectedIndex: mediaIndex,
                    child: MediaList(
                      medias: getMedias(mediaIndex),
                      toggleLikeCallback: toggleFav,
                      onTap: (media) {
                        GoRouter.of(context).push('/medias/info/${media.id}');
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'info/:mediaId',
                    parentNavigatorKey: appShellNavigatorKey,
                    builder: (context, state) {
                      return MediaDetailsScreen(
                        media: libraryInstance
                            .getMedia(state.pathParameters['mediaId'] ?? ''),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/liked',
                builder: (context, state) {
                  return LikedScreen(
                    child: MediaList(
                      medias: libraryInstance.liked,
                      toggleLikeCallback: toggleFav,
                      onTap: (media) {
                        GoRouter.of(context).push('/medias/info/${media.id}');
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'info/:mediaId',
                    parentNavigatorKey: appShellNavigatorKey,
                    builder: (context, state) {
                      return MediaDetailsScreen(
                        media: libraryInstance
                            .getMedia(state.pathParameters['mediaId'] ?? ''),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
