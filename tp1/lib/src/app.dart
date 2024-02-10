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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/medias/films',
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
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    // Use a builder to get the correct BuildContext
                    // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                    child: Builder(builder: (context) {
                      return MediasScreen(
                        onTap: (idx) {
                          GoRouter.of(context).go(switch (idx) {
                            0 => '/medias/films',
                            1 => '/medias/series',
                            2 => '/medias/livres',
                            _ => '/medias/films',
                          });
                        },
                        selectedIndex: switch (state.uri.path) {
                          var p when p.startsWith('/medias/films') => 0,
                          var p when p.startsWith('/medias/series') => 1,
                          var p when p.startsWith('/medias/livres') => 2,
                          _ => 0,
                        },
                        child: child,
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/medias/films',
                    builder: (context, state) {
                      return MediaList(
                        medias: libraryInstance.films,
                        toggleLikeCallback: toggleFav,
                        onTap: (media) {
                          GoRouter.of(context)
                              .push('/medias/films/info/${media.id}');
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'info/:mediaId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MediaDetailsScreen(
                            media: libraryInstance.getMedia(
                                state.pathParameters['mediaId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/medias/series',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        // Use a builder to get the correct BuildContext
                        // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                        child: Builder(
                          builder: (context) {
                            return MediaList(
                              medias: libraryInstance.series,
                              toggleLikeCallback: toggleFav,
                              onTap: (media) {
                                GoRouter.of(context)
                                    .push('/medias/series/info/${media.id}');
                              },
                            );
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
                            media: libraryInstance.getMedia(
                                state.pathParameters['mediaId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/medias/livres',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        // Use a builder to get the correct BuildContext
                        // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                        child: Builder(
                          builder: (context) {
                            return MediaList(
                              medias: libraryInstance.livres,
                              toggleLikeCallback: toggleFav,
                              onTap: (media) {
                                GoRouter.of(context)
                                    .push('/medias/livres/info/${media.id}');
                              },
                            );
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
                            media: libraryInstance.getMedia(
                                state.pathParameters['mediaId'] ?? ''),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    // Use a builder to get the correct BuildContext
                    // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                    child: Builder(builder: (context) {
                      return LikedScreen(
                        child: child,
                      );
                    }),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/liked',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        // Use a builder to get the correct BuildContext
                        // TODO (johnpryan): remove when https://github.com/flutter/flutter/issues/108177 lands
                        child: Builder(
                          builder: (context) {
                            return MediaList(
                              medias: libraryInstance.liked,
                              toggleLikeCallback: toggleFav,
                              onTap: (media) {
                                GoRouter.of(context)
                                    .push('/liked/info/${media.id}');
                              },
                            );
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
                            media: libraryInstance.getMedia(
                                state.pathParameters['mediaId'] ?? ''),
                          );
                        },
                      ),
                    ],
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
